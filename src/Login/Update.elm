module Login.Update exposing (update)

import Browser
import Browser.Navigation
import Login.Model exposing (Model, Msg(..))
import Login.Ports as Ports
import Login.Router as Router
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlChange url ->
            ( { model | route = Router.toRoute url }, Ports.urlChanged (Url.toString url) )

        OnUrlRequest (Browser.Internal url) ->
            ( { model | route = Router.toRoute url }, Ports.urlChanged (Url.toString url) )

        OnUrlRequest (Browser.External href) ->
            ( model, Browser.Navigation.load href )

        GoTo route ->
            ( { model | route = route }, Ports.urlChanged (Router.toString route) )
