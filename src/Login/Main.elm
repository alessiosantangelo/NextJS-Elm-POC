module Login.Main exposing (main)

import Browser
import Browser.Navigation
import Login.Model as Model exposing (Flags, Model, Msg)
import Login.Update as Update
import Login.View as View
import Url exposing (Url)


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = View.view
        , update = Update.update
        , subscriptions = always Sub.none
        , onUrlRequest = Model.OnUrlRequest
        , onUrlChange = Model.OnUrlChange
        }


init : Flags -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model.initialModel flags url key, Cmd.none )
