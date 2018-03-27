module User exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Models exposing (User)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)


viewUser: WebData User -> Html Msg
viewUser response =
    case response of
        RemoteData.NotAsked ->
            text "XXX"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success user ->
            text user.id

        RemoteData.Failure error ->
            text "Error"