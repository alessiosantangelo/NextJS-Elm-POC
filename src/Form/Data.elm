module Form.Data exposing
    ( Data(..)
    , claimTypeValidation
    , dateValidation
    , initialData
    , insuranceTypeValidation
    , involvedPeopleValidation
    , isInsuranceTypeHousehold
    , isInsuranceTypeMotor
    , notEmptyStringValidation
    , ownedVehiclesValidation
    , privacyValidation
    , residentialCityValidation
    , residentialProvinceValidation
    , updateBirthDate
    , updateClaimDate
    , updateClaimType
    , updateDynamic
    , updateInsuranceType
    , updatePeopleInvolved
    , updatePlate
    , updatePrivacyChanged
    , updateResidentialCity
    , updateResidentialCityRemoteData
    , updateResidentialProvince
    , updateVehiclesOwn
    )

import Date exposing (Date)
import Form.Api.City as City exposing (City)
import Form.Msg exposing (Msg)
import Form.Types as Types
import Http
import PrimaFunction
import Pyxis.Components.Field.Autocomplete as Autocomplete
import Pyxis.Components.Field.CheckboxGroup as CheckboxGroup
import Pyxis.Components.Field.Input as Input
import Pyxis.Components.Field.RadioCardGroup as RadioCardGroup
import Pyxis.Components.Field.Select as Select
import Pyxis.Components.Field.Textarea as Textarea
import RemoteData exposing (RemoteData)


type Data
    = Data
        { isFormSubmitted : Bool
        , birth : Input.Model Msg
        , claimDate : Input.Model Msg
        , claimType : RadioCardGroup.Model Types.Claim Msg
        , dynamic : Textarea.Model Msg
        , insuranceType : RadioCardGroup.Model Types.Insurance Msg
        , peopleInvolved : RadioCardGroup.Model Bool Msg
        , plate : Input.Model Msg
        , privacyCheck : CheckboxGroup.Model Types.Option Msg
        , residentialCity : Autocomplete.Model String Msg
        , residentialProvince : Select.Model Msg
        , vehiclesOwn : CheckboxGroup.Model Types.Vehicles Msg
        }


initialData : Data
initialData =
    Data
        { isFormSubmitted = False
        , birth = Input.init
        , claimDate = Input.init
        , claimType = RadioCardGroup.init
        , dynamic = Textarea.init
        , insuranceType = RadioCardGroup.init
        , peopleInvolved = RadioCardGroup.init
        , plate = Input.init
        , privacyCheck = CheckboxGroup.init
        , residentialCity = Autocomplete.init
        , residentialProvince = Select.init
        , vehiclesOwn = CheckboxGroup.init
        }



-- Mappers


updateBirthDate : Input.Msg -> Data -> ( Data, Cmd Msg )
updateBirthDate msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Input.update msg d.birth
    in
    ( Data { d | birth = componentModel }, componentCmd )


updateClaimDate : Input.Msg -> Data -> ( Data, Cmd Msg )
updateClaimDate msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Input.update msg d.claimDate
    in
    ( Data { d | claimDate = componentModel }, componentCmd )


updateDynamic : Textarea.Msg -> Data -> ( Data, Cmd Msg )
updateDynamic msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Textarea.update msg d.dynamic
    in
    ( Data { d | dynamic = componentModel }, componentCmd )


updatePlate : Input.Msg -> Data -> ( Data, Cmd Msg )
updatePlate msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Input.update msg d.plate
    in
    ( Data { d | plate = componentModel }, componentCmd )


updateResidentialCity : Autocomplete.Msg String -> Data -> ( Data, Cmd Msg )
updateResidentialCity msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Autocomplete.update msg d.residentialCity
    in
    ( Data { d | residentialCity = componentModel }, componentCmd )


updateResidentialCityRemoteData : RemoteData Http.Error (List City) -> Data -> ( Data, Cmd Msg )
updateResidentialCityRemoteData remoteData (Data d) =
    let
        options : RemoteData Http.Error (List (Autocomplete.Option String))
        options =
            RemoteData.map (List.map (\c -> Autocomplete.option { value = City.getIstatCode c, label = City.getName c })) remoteData
    in
    ( Data { d | residentialCity = Autocomplete.setOptions options d.residentialCity }, Cmd.none )


updateResidentialProvince : Select.Msg -> Data -> ( Data, Cmd Msg )
updateResidentialProvince msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            Select.update msg d.residentialProvince
    in
    ( Data { d | residentialProvince = componentModel }, componentCmd )


updateInsuranceType : RadioCardGroup.Msg Types.Insurance -> Data -> ( Data, Cmd Msg )
updateInsuranceType msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            RadioCardGroup.update msg d.insuranceType
    in
    ( Data { d | insuranceType = componentModel }, componentCmd )


updateClaimType : RadioCardGroup.Msg Types.Claim -> Data -> ( Data, Cmd Msg )
updateClaimType msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            RadioCardGroup.update msg d.claimType
    in
    ( Data { d | claimType = componentModel }, componentCmd )


updatePeopleInvolved : RadioCardGroup.Msg Bool -> Data -> ( Data, Cmd Msg )
updatePeopleInvolved msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            RadioCardGroup.update msg d.peopleInvolved
    in
    ( Data { d | peopleInvolved = componentModel }, componentCmd )


updatePrivacyChanged : CheckboxGroup.Msg Types.Option -> Data -> ( Data, Cmd Msg )
updatePrivacyChanged msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            CheckboxGroup.update msg d.privacyCheck
    in
    ( Data { d | privacyCheck = componentModel }, componentCmd )


updateVehiclesOwn : CheckboxGroup.Msg Types.Vehicles -> Data -> ( Data, Cmd Msg )
updateVehiclesOwn msg (Data d) =
    let
        ( componentModel, componentCmd ) =
            CheckboxGroup.update msg d.vehiclesOwn
    in
    ( Data { d | vehiclesOwn = componentModel }, componentCmd )



-- Validations


notEmptyStringValidation : String -> Result String String
notEmptyStringValidation value =
    if String.isEmpty value then
        Err "This field cannot be empty."

    else
        Ok value


cardValidation : value -> Data -> Maybe value -> Result String value
cardValidation default (Data data) value =
    value
        |> Maybe.map Ok
        |> Maybe.withDefault
            (PrimaFunction.ifThenElse data.isFormSubmitted
                (Err "Select at least one option.")
                (Ok default)
            )


dateValidation : String -> Result String Date.Date
dateValidation =
    Date.fromIsoString


claimTypeValidation : Maybe Types.Claim -> Result String Types.Claim
claimTypeValidation =
    Result.fromMaybe "Choose a claim type."


insuranceTypeValidation : Maybe Types.Insurance -> Result String Types.Insurance
insuranceTypeValidation =
    Result.fromMaybe "Choose an insurance type."


involvedPeopleValidation : Maybe Bool -> Result String Bool
involvedPeopleValidation =
    Result.fromMaybe "Select whether or not people were involved."


residentialCityValidation : Maybe String -> Result String String
residentialCityValidation =
    Result.fromMaybe "Choose a residential city."


residentialProvinceValidation : Maybe String -> Result String String
residentialProvinceValidation =
    Result.fromMaybe "Choose a residential province."


privacyValidation : List Types.Option -> Result String (List Types.Option)
privacyValidation list =
    if List.isEmpty list then
        Err "You must agree to privacy policy."

    else
        Ok [ Types.AcceptPrivacy ]


ownedVehiclesValidation : List Types.Vehicles -> Result String (List Types.Vehicles)
ownedVehiclesValidation list =
    if List.length list < 2 then
        Err "Select at least two options"

    else
        Ok list



-- Readers


isInsuranceTypeMotor : Data -> Bool
isInsuranceTypeMotor (Data d) =
    RadioCardGroup.getValue d.insuranceType == Just Types.Motor


isInsuranceTypeHousehold : Data -> Bool
isInsuranceTypeHousehold (Data d) =
    RadioCardGroup.getValue d.insuranceType == Just Types.Household
