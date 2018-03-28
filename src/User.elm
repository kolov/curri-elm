module User exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (User, Model)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)



loginForm: String -> Html Msg
loginForm origin = Html.form
                      [ action (origin ++ "/login/google/aHR0cDovL2N1cnJpLnhpcC5pbzo4MDAx"), method "get" ]
                      [ input
                        [  type_ "submit"
                         , class "btn btn-outline-success my-2 my-sm-0", type_ "submit"
                         ,  value "Login"
                        ]
                        [button [class "btn btn-outline-success my-2 my-sm-0", type_ "submit" ] [ text "Login" ]]
                      ]

logoutForm: String -> Html Msg
logoutForm origin =
                       button [class "btn btn-outline-success my-2 my-sm-0", onClick Msgs.Logout] [ text "Logout" ]


userArea: String -> User -> Html Msg
userArea origin user =
  case user.identity of
   Just identity -> div [] [
                    div [] [
                      text ("Hello, " ++ (Maybe.withDefault  identity.email  identity.givenName))]
                    , div [] [logoutForm origin]
                    ]
   Nothing -> div [] [loginForm origin]


viewUser: String -> WebData User -> Html Msg
viewUser origin user =
    case user of
        RemoteData.NotAsked ->
            text "?"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success user ->
            userArea origin user

        RemoteData.Failure error ->
            text ("RemoteData.Failure" ++ (toString error))