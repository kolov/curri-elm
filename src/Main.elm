module Main exposing (..)

import Commands exposing (fetchInitialData)
import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import MainView exposing (mainView)
import Debug

init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
        _ = Debug.log (toString currentRoute)
    in
        ( initialModel currentRoute, fetchInitialData )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { init = init
        , view = mainView
        , update = update
        , subscriptions = subscriptions
        }
