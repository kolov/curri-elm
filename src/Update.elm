module Update exposing (..)

import Commands exposing (savePlayerCmd, fetchUser)
import Models exposing (Model, Player)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData
import Navigation exposing (..)
import Debug exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchPlayers response ->
            let
              _ = Debug.log (toString response)
            in
            ( { model | players = response }, Cmd.none )

        Msgs.FetchUser  -> (model, Commands.fetchUser model.flags.endpoints.users)

        Msgs.OnFetchUser response ->
            let
              _ = Debug.log (toString response)
            in
            ( { model | user = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, savePlayerCmd updatedPlayer )

        Msgs.OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        Msgs.OnPlayerSave (Err error) ->
            ( model, Cmd.none )

        Msgs.Login -> (model,  Navigation.load "/service/login")
        Msgs.Logout  -> (model,  Commands.logoutUser)
        Msgs.OnLogout _ -> (model,  fetchUser model.flags.endpoints.users)
        Msgs.ShowCookiesConsent -> (model,  Cmd.none)
        Msgs.HideCookiesConsent -> (model,  Cmd.none)


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
