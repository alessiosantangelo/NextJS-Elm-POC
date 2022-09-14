module Login.Model exposing (Flags, Model, Msg(..), initialModel)

import Browser
import Browser.Navigation
import Login.Router as Router
import Url exposing (Url)


type alias Flags =
    {}


type alias Model =
    { key : Browser.Navigation.Key
    , route : Router.Route
    }


type Msg
    = OnUrlChange Url
    | OnUrlRequest Browser.UrlRequest
    | GoTo Router.Route


initialModel : Flags -> Url -> Browser.Navigation.Key -> Model
initialModel flags url key =
    { key = key, route = Maybe.withDefault Router.NotFound (Router.toRoute url) }
