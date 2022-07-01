module Login.Router exposing (Route(..), parser, toRoute)

import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>), int, s, string)


type Route
    = Login
    | LoggedIn
    | NotFound


parser : Url.Parser.Parser (Route -> a) a
parser =
    Url.Parser.oneOf
        [ Url.Parser.map LoggedIn (s "logged")
        , Url.Parser.map Login (s "login")
        , Url.Parser.map Login Url.Parser.top
        ]


toRoute : Url -> Route
toRoute =
    Url.Parser.parse parser >> Maybe.withDefault NotFound
