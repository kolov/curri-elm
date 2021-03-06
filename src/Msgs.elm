module Msgs exposing (..)

import Http
import Models exposing (Player, PlayerId, User)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
    | Login
    | Logout
    | OnLogout (WebData String)
    | FetchUser
    | OnFetchUser (WebData User)
    | OnLocationChange Location
    | ChangeLevel Player Int
    | OnPlayerSave (Result Http.Error Player)
    | ShowCookiesConsent | HideCookiesConsent
