module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (Flags, Identity, Player, PlayerId, User, UserPreferencies)
import RemoteData
import Platform.Cmd exposing (batch)

backend : String
backend = "http://civi.akolov.com/"

fetchInitialData : Flags -> Cmd Msg
fetchInitialData flags =
     batch [ fetchPlayers flags.endpoints.players,
           fetchUser flags.endpoints.users]

fetchPlayers : String -> Cmd Msg
fetchPlayers backend =
    Http.get (backend ++ "/players") playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


fetchUser : String -> Cmd Msg
fetchUser origin =
    Http.get (origin ++ "/user-details") userDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchUser


logoutUser : Cmd Msg
logoutUser =
    Http.post (backend ++ "/logout") Http.emptyBody Decode.string
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnLogout

savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
    "http://localhost:4000/players/" ++ playerId


savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
    Http.request
        { body = playerEncoder player |> Http.jsonBody
        , expect = Http.expectJson playerDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = savePlayerUrl player.id
        , withCredentials = False
        }


savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
    savePlayerRequest player
        |> Http.send Msgs.OnPlayerSave


--loginCmd : () -> Cmd Msg
--loginCmd =
--    savePlayerRequest player
--        |> Http.send Msgs.OnPlayerSave


-- DECODERS


playersDecoder : Decode.Decoder (List Player)
playersDecoder =
    Decode.list playerDecoder


playerDecoder : Decode.Decoder Player
playerDecoder =
    decode Player
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "level" Decode.int


identityDecoder : Decode.Decoder Identity
identityDecoder =
    decode Identity
        |> required "sub" Decode.string
        |> required "email" Decode.string
        |> optional "familyName" (Decode.map Just Decode.string) Nothing
        |> optional "gender" (Decode.map Just Decode.string) Nothing
        |> optional "givenName" (Decode.map Just Decode.string) Nothing
        |> optional "locale" (Decode.map Just Decode.string) Nothing
        |> optional "name" (Decode.map Just Decode.string) Nothing
        |> optional "picture" (Decode.map Just Decode.string) Nothing
        |> optional "profile" (Decode.map Just Decode.string) Nothing

userPrefsDecoder : Decode.Decoder UserPreferencies
userPrefsDecoder =
    decode UserPreferencies
         |> required "acceptsCookies" Decode.bool

userDecoder : Decode.Decoder User
userDecoder =
    decode User
        |> required "id" Decode.string
        |> optional "identity" (Decode.map Just identityDecoder) Nothing
        |> required "prefs" userPrefsDecoder


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        attributes =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        Encode.object attributes


