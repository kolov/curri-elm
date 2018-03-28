module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    , user  : WebData( User)
    , origin : String
    }


initialModel : Route -> String -> Model
initialModel route origin =
    { players = RemoteData.Loading
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

type alias User =
    { id : String
    , identity : Maybe Identity
    }


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
