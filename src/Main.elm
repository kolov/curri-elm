module Main exposing (..)

import Commands exposing (fetchInitialData)
import Models exposing (Flags, Model, initialModel)
import Msgs exposing (Msg)
import Navigation exposing (Location)
import Routing
import Update exposing (update)
import MainView exposing (mainView)
import Debug

init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute = Routing.parseLocation location
        _ = Debug.log (toString currentRoute)
        _ = Debug.log ("Flags" ++ (toString flags))
    in
        ( initialModel currentRoute location.origin flags
        , fetchInitialData )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN



main : Program Flags Model Msg
main =
    Navigation.programWithFlags Msgs.OnLocationChange
        { init = init
        , view = mainView
        , update = update
        , subscriptions = subscriptions
        }
