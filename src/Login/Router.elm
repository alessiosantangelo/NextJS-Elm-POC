module Login.Router exposing
    ( Route(..)
    , parser
    , toRoute
    , toString
    )

import Url exposing (Url)
import Url.Parser exposing ((</>), s)


type Route
    = Login
    | LoggedIn
    | NotFound


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map LoggedIn (s "login" </> s "logged")
        , Url.Parser.map Login (s "login")
        ]


toRoute : Url -> Maybe Route
toRoute =
    Url.Parser.parse parser


toString : Route -> String
toString route =
    case route of
        Login ->
            "/login"

        LoggedIn ->
            "/login/logged"

        NotFound ->
            "/404-not-found"
