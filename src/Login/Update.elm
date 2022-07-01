module Login.Update exposing (update)

import Browser
import Browser.Navigation
import Login.Model exposing (Model, Msg(..))
import Login.Router as Router


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnUrlChange url ->
            ( { model | route = Router.toRoute url }, Cmd.none )

        OnUrlRequest (Browser.Internal url) ->
            ( { model | route = Router.toRoute url }, Cmd.none )

        OnUrlRequest (Browser.External href) ->
            ( model, Browser.Navigation.load href )

        GoTo route ->
            ( { model | route = route }, Cmd.none )
