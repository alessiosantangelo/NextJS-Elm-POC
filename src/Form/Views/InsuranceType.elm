module Form.Views.InsuranceType exposing (view)

import Form.Data exposing (Data(..))
import Form.Msg as Msg exposing (Msg)
import Form.Types as Fields
import Pyxis.Components.Field.Error.Strategy as Strategy
import Pyxis.Components.Field.RadioCardGroup as RadioCardGroup
import Pyxis.Components.Form.FieldSet as FieldSet
import Pyxis.Components.Form.Grid as Grid
import Pyxis.Components.Form.Grid.Row as Row
import Pyxis.Components.Form.Legend as Legend


view : Data -> FieldSet.Config Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.simpleOneColRow
                [ Legend.config "Insurance type"
                    |> Legend.withDescription "Pay attention to our hints! They'll make the process faster and easier."
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.row
                [ Row.mediumSize ]
                [ Grid.simpleCol
                    [ "insurance-type"
                        |> RadioCardGroup.config
                        |> RadioCardGroup.withStrategy Strategy.onSubmit
                        |> RadioCardGroup.withIsSubmitted config.isFormSubmitted
                        |> RadioCardGroup.withSize RadioCardGroup.large
                        |> RadioCardGroup.withOptions
                            [ RadioCardGroup.option
                                { value = Fields.Motor
                                , title = Just "Vehicles"
                                , text = Nothing
                                , addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg"
                                }
                            , RadioCardGroup.option
                                { value = Fields.Household
                                , title = Just "Household and family"
                                , text = Nothing
                                , addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg"
                                }
                            ]
                        |> RadioCardGroup.render Msg.InsuranceTypeChanged data config.insuranceType
                    ]
                ]
            ]
