module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { players : WebData (List Player)
    , route : Route
    , user  : WebData( User)
    }


initialModel : Route -> Model
initialModel route =
    { players = RemoteData.Loading
    , route = route
    , user  = RemoteData.Loading
    }


type alias PlayerId =
    String


type alias Identity =
    { id : PlayerId
    , name : String
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
