module Models exposing (..)

import RemoteData exposing (WebData)

type alias Flags =
    {
        endpoints : {
          auth: String,
          users: String,
          players: String
        }
    }
type alias Model =
    { flags: Flags
    , players : WebData (List Player)
    , route : Route
    , user  : WebData( User)
    , origin : String
    }


initialModel : Route -> String -> Flags -> Model
initialModel route origin flags =
    { flags = flags
    , players = RemoteData.Loading
    , route = route
    , user  = RemoteData.Loading
    , origin = origin
    }


type alias PlayerId =
    String


type alias Identity =
    {  sub: String
       ,email: String
       ,familyName: Maybe String
       ,gender: Maybe String
       ,givenName: Maybe String
       ,locale: Maybe String
       ,name: Maybe String
       ,picture: Maybe String
       ,profile: Maybe String
    }


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }

type alias UserPreferencies =
    {
      acceptsCookies: Bool
    }

type alias User =
    { id : String
    , identity : Maybe Identity
    , prefs : UserPreferencies
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
