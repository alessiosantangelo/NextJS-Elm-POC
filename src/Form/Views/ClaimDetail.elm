module Form.Views.ClaimDetail exposing (view)

import Form.Data as Data exposing (Data(..))
import Form.Msg as Msg exposing (Msg)
import Html
import Html.Attributes
import Pyxis.Components.Button as Button
import Pyxis.Components.Field.Error as Error
import Pyxis.Components.Field.Label as Label
import Pyxis.Components.Field.RadioCardGroup as RadioCardGroup
import Pyxis.Components.Field.Textarea as Textarea
import Pyxis.Components.Form.FieldSet as FieldSet
import Pyxis.Components.Form.Grid as Grid
import Pyxis.Components.Form.Grid.Row as Row
import Pyxis.Components.Form.Legend as Legend


view : Data -> FieldSet.Config Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.oneColRowSmall
                [ Legend.config "Claim details"
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.oneColRowSmall
                [ "people-involved"
                    |> RadioCardGroup.config
                    |> RadioCardGroup.withValidationOnSubmit Data.involvedPeopleValidation config.isFormSubmitted
                    |> RadioCardGroup.withLabel (Label.config "Is there any involved people?")
                    |> RadioCardGroup.withOptions
                        [ RadioCardGroup.option { value = True, title = Nothing, text = Just "Yes", addon = Nothing }
                        , RadioCardGroup.option { value = False, title = Nothing, text = Just "No", addon = Nothing }
                        ]
                    |> RadioCardGroup.render Msg.PeopleInvolvedChanged config.peopleInvolved
                ]
            , Grid.oneColRowSmall
                [ "claim-dynamic"
                    |> Textarea.config
                    |> Textarea.withValidationOnSubmit Data.notEmptyStringValidation config.isFormSubmitted
                    |> Textarea.withLabel (Label.config "Dynamic")
                    |> Textarea.withPlaceholder "Briefly describe the dynamics of the accident."
                    |> Textarea.withHint "Max. 300 words."
                    |> Textarea.render Msg.DynamicsChanged config.dynamic
                ]
            ]
        |> FieldSet.withFooter
            [ Grid.oneColRowSmall
                [ Html.div
                    [ Html.Attributes.class "button-row"
                    , Html.Attributes.style "justify-content" "center"
                    ]
                    [ Button.primary
                        |> Button.withType Button.button
                        |> Button.withOnClick Msg.Submit
                        |> Button.withText "Send"
                        |> Button.render
                    ]
                ]
            ]
