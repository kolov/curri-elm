module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (PlayerId, Player, User, Identity)
import RemoteData
import Platform.Cmd exposing (batch)

backend : String
backend = ""

fetchInitialData : Cmd Msg
fetchInitialData =
     batch [fetchPlayers, fetchUser]

fetchPlayers : Cmd Msg
fetchPlayers =
    Http.get fetchPlayersUrl playersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPlayers


fetchUser : Cmd Msg
fetchUser =
    Http.get (backend ++ "/service/user") userDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchUser


fetchPlayersUrl : String
fetchPlayersUrl =
    "http://localhost:4000/players"




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
        |> required "id" Decode.string
        |> required "name" Decode.string

userDecoder : Decode.Decoder User
userDecoder =
    decode User
        |> required "id" Decode.string
        |> optional "identity" (Decode.map Just identityDecoder) Nothing


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


