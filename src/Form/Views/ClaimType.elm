module Form.Views.ClaimType exposing (view)

import Form.Data exposing (Data(..))
import Form.Msg as Msg exposing (Msg)
import Form.Types as Fields
import Html
import Html.Attributes
import Pyxis.Components.Button as Button
import Pyxis.Components.Field.Error as Error
import Pyxis.Components.Field.RadioCardGroup as RadioCardGroup
import Pyxis.Components.Form.FieldSet as FieldSet
import Pyxis.Components.Form.Grid as Grid
import Pyxis.Components.Form.Grid.Row as Row
import Pyxis.Components.Form.Legend as Legend
import Pyxis.Components.IconSet as IconSet


view : Data -> FieldSet.Config Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.oneColRowSmall
                [ Legend.config "Choose the accident type"
                    |> Legend.withImage "../../../assets/placeholder.svg"
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.oneColRowSmall
                [ "claim-type"
                    |> RadioCardGroup.config
                    --|> RadioCardGroup.withStrategy Strategy.onSubmit
                    --|> RadioCardGroup.withIsSubmitted config.isFormSubmitted
                    |> RadioCardGroup.withLayout RadioCardGroup.vertical
                    |> RadioCardGroup.withOptions
                        [ RadioCardGroup.option
                            { value = Fields.CarAccident
                            , title = Just "Car crash"
                            , text = Just "Lorem ipsum dolor sit amet."
                            , addon = RadioCardGroup.addonIcon IconSet.VehicleCollisionKasko
                            }
                        , RadioCardGroup.option
                            { value = Fields.OtherClaims
                            , title = Just "Others"
                            , text = Just "Theft, fire, etc."
                            , addon = RadioCardGroup.addonIcon IconSet.VehicleFullKasko
                            }
                        ]
                    |> RadioCardGroup.render Msg.ClaimTypeChanged config.claimType
                ]
            ]
        |> FieldSet.withFooter
            [ Grid.oneColRowSmall
                [ Html.div
                    [ Html.Attributes.class "button-row"
                    , Html.Attributes.style "justify-content" "center"
                    ]
                    [ Button.secondary
                        |> Button.withType Button.button
                        |> Button.withOnClick (Msg.ShowModal True)
                        |> Button.withText "Read more about our policy."
                        |> Button.render
                    ]
                ]
            ]
