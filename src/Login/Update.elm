module Login.Update exposing (update)

import Browser
import Browser.Navigation
import Login.Model exposing (Model, Msg(..))
import Login.Router as Router
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "update" msg of
        OnUrlChange url ->
            ( { model | route = Maybe.withDefault Router.NotFound (Router.toRoute url) }
            , url
                |> Router.toRoute
                |> Maybe.map (always Cmd.none)
                |> Maybe.withDefault (Browser.Navigation.load (Url.toString url))
            )

        OnUrlRequest (Browser.Internal url) ->
            ( { model | route = Maybe.withDefault Router.NotFound (Router.toRoute url) }
            , Cmd.none
            )

        OnUrlRequest (Browser.External href) ->
            ( model
            , Browser.Navigation.load href
            )

        GoTo route ->
            ( { model | route = route }
            , Browser.Navigation.pushUrl model.key (Router.toString route)
            )
