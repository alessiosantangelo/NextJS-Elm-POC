module Login.View exposing (view)

import Browser
import Html exposing (Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Login.Model as Model exposing (Model, Msg(..))
import Login.Router as Router


view : Model -> Browser.Document Msg
view model =
    { title = "Elm SPA within React environment"
    , body = viewByRoute model
    }


viewByRoute : Model -> List (Html Msg)
viewByRoute model =
    case model.route of
        Router.Login ->
            loginView model

        Router.LoggedIn ->
            loggedInView model

        Router.NotFound ->
            notFoundView model


loginView : Model -> List (Html Msg)
loginView model =
    [ Html.h1 [] [ Html.text "Login" ]
    , Html.button
        [ class "button button--primary button--large"
        , onClick (Model.GoTo Router.LoggedIn)
        ]
        [ Html.text "Login" ]
    ]


loggedInView : Model -> List (Html Msg)
loggedInView model =
    [ Html.h1 [] [ Html.text "You're now logged in." ]
    ]


notFoundView : Model -> List (Html Msg)
notFoundView model =
    [ Html.h1 [] [ Html.text "Oops. Page not found." ]
    ]
