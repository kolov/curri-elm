module MainView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (Model, PlayerId)
import Models exposing (Model)
import Msgs exposing (Msg)
import View exposing( page)
import User exposing (viewCookiesConsent, viewUser)




mainView : Model -> Html Msg
mainView model =
  div []
      [ nav [ class "navbar navbar-expand-lg navbar-light bg-light" ]
          [ a [ class "navbar-brand", href "#" ]
              [ text "Navbar" ]
          , button [ attribute "aria-controls" "navbarSupportedContent", attribute "aria-expanded" "false", attribute "aria-label" "Toggle navigation", class "navbar-toggler", attribute "data-target" "#navbarSupportedContent", attribute "data-toggle" "collapse", type_ "button" ]
              [ span [ class "navbar-toggler-icon" ]
                  []
              ]
          , div [ class "collapse navbar-collapse", id "navbarSupportedContent" ]
              [ ul [ class "navbar-nav mr-auto" ]
                  [ li [ class "nav-item active" ]
                      [ a [ class "nav-link", href "#" ]
                          [ text "Home "
                          , span [ class "sr-only" ]
                              [ text "(current)" ]
                          ]
                      ]
                  , li [ class "nav-item" ]
                      [ a [ class "nav-link", href "#" ]
                          [ text "Link" ]
                      ]
                  , li [ class "nav-item dropdown" ]
                      [ a [ attribute "aria-expanded" "false", attribute "aria-haspopup" "true", class "nav-link dropdown-toggle", attribute "data-toggle" "dropdown", href "#", id "navbarDropdown", attribute "role" "button" ]
                          [ text "Dropdown              " ]
                      , div [ attribute "aria-labelledby" "navbarDropdown", class "dropdown-menu" ]
                          [ a [ class "dropdown-item", href "#" ]
                              [ text "Action" ]
                          , a [ class "dropdown-item", href "#" ]
                              [ text "Another action" ]
                          , div [ class "dropdown-divider" ]
                              []
                          , a [ class "dropdown-item", href "#" ]
                              [ text "Something else here" ]
                          ]
                      ]
                  , li [ class "nav-item" ]
                      [ a [ class "nav-link disabled", href "#" ]
                          [ text "Disabled" ]
                      ]
                  ]
--              , div [ class "form-inline my-2 my-lg-0" ]
--                  [ viewUser model.user
--                  , button [ class "btn btn-outline-success my-2 my-sm-0", type_ "submit" ]
--                      [ button [ onClick Msgs.Login ] [ text "Login" ]]
--
--
--
--
--                  ]

              , div [ class "form-inline my-2 my-lg-0" ]
                  [

                   viewUser model.flags.endpoints.auth model.user
--                  Html.form [ action "/service/login", method "post"]
--                                                          , button [] [ text "Submit" ]



                  ]
              , div [class "cookie-consent"]
                  [
                    viewCookiesConsent  model.flags.endpoints.users model.user
                  ]





              ]
          ]
      , div [ class "container" ]
          [ div [ id "main" ]
              [ page model ]
          ]
      ]
