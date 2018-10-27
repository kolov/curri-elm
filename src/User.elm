module User exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (User, Model)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Base64 exposing(..)


loginForm: String -> Html Msg
loginForm origin = Html.form
                      [ action (origin ++ "/login/google/" ++  Base64.encode(origin) ), method "get" ]
                      [ input
                        [  type_ "submit"
                         , class "btn btn-outline-success my-2 my-sm-0", type_ "submit"
                         ,  value "Login"
                        ]
                        []
                      ]

logoutForm: String -> Html Msg
logoutForm origin =
                       button [class "btn btn-outline-success my-2 my-sm-0", onClick Msgs.Logout] [ text "Logout" ]


cookieConsentArea: String -> User -> Html Msg
cookieConsentArea userService user =
  case user.prefs.acceptsCookies of
   False -> div [] [
                    div [] [
                      text ("Hello, " ++ "You need to accept cookies")]
--                    , div [] [logoutForm authOrigin]
                    ]
   True -> text ""

userArea: String -> User -> Html Msg
userArea authOrigin user =
  case user.identity of
   Just identity -> div [] [
                    div [] [
                      text ("Hello, " ++ (Maybe.withDefault  identity.email  identity.givenName))]
                    , div [] [logoutForm authOrigin]
                    ]
   Nothing -> div [] [loginForm authOrigin]


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

viewCookiesConsent : String -> WebData User -> Html Msg
viewCookiesConsent userService user =
     case user of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success user ->
            cookieConsentArea userService user

        RemoteData.Failure error ->
            text "!"