module Form.View exposing (view)

import Form.Data as Data exposing (Data)
import Form.Model as Model exposing (Model)
import Form.Msg exposing (Msg)
import Form.Views.BaseInformation as BaseInformation
import Form.Views.ClaimDetail as ClaimDetail
import Form.Views.ClaimType as ClaimType
import Form.Views.Faqs as Faqs
import Form.Views.InsuranceType as InsuranceType
import Form.Views.Modal as Modal
import Form.Views.RequestFailed as RequestFailed
import Form.Views.RequestReceived as RequestReceived
import Html exposing (Html)
import Html.Attributes
import Pyxis.Commons.Render as CommonsRender
import Pyxis.Components.Form as Form
import Result.Extra


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.class "container padding-v-xl margin-v-xl" ]
        [ viewport
        , viewForm model.data
        , Html.div
            [ Html.Attributes.class "container-small padding-v-m margin-v-xl" ]
            [ RequestReceived.view
                |> CommonsRender.renderIf (Result.Extra.isOk (Model.validate model.data))
            , RequestFailed.view
                |> CommonsRender.renderIf (Data.isInsuranceTypeHousehold model.data)
            ]
        , Modal.view model.showModal
        , Html.div
            [ Html.Attributes.class "container-responsive padding-v-m margin-v-xl" ]
            [ Html.text "Any question? Check out our FAQs:"
            , Faqs.view model
            ]
        ]


viewport : Html msg
viewport =
    Html.node "meta"
        [ Html.Attributes.name "viewport"
        , Html.Attributes.attribute "content" "width=device-width, initial-scale=1"
        ]
        []


viewForm : Data -> Html Msg
viewForm data =
    Form.config
        |> Form.withDynamicFieldSets
            [ ( InsuranceType.view data, True )
            , ( BaseInformation.view data, Data.isInsuranceTypeMotor data )
            , ( ClaimType.view data, Data.isInsuranceTypeMotor data )
            , ( ClaimDetail.view data, Data.isInsuranceTypeMotor data )
            ]
        |> Form.render
