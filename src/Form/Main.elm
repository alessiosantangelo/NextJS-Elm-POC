module Form.Main exposing (main)

import Browser
import Form.Model as Model exposing (Model)
import Form.Msg exposing (Msg)
import Form.Update as Update
import Form.View as View
import PrimaUpdate


main : Program () Model Msg
main =
    Browser.document
        { init = always (PrimaUpdate.withoutCmds Model.initialModel)
        , view = \model -> { title = "Example app", body = [ View.view model ] }
        , update = Update.update
        , subscriptions = always Sub.none
        }
