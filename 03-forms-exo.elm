import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

import String
import Char


main =
    Html.beginnerProgram {
        model = model,
        view = view,
        update = update
        }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , message : String
    , mColor : String
    , age : String
    }


model : Model
model =
    Model "" "" "" "" "" ""


type Msg =
    Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name n ->
            { model | name = n }

        Password pwd ->
            { model | password = pwd}

        PasswordAgain pwda ->
            { model | passwordAgain = pwda }

        Age age ->
            { model | age = age }

        Submit ->
            modelValidation model


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text",     placeholder "Name",              onInput Name          ] []
        , input [ type_ "text",     placeholder "Age",               onInput Age           ] []
        , input [ type_ "password", placeholder "Password",          onInput Password      ] []
        , input [ type_ "password", placeholder "Re-enter password", onInput PasswordAgain ] []
        , button [onClick Submit ] [text "Submit"]
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    div [style [("color", model.mColor)] ] [ text model.message ]


modelValidation : Model -> Model
modelValidation model =
    let
        (color, message) =
            if model.name == ""
               || model.password == ""
               || model.passwordAgain == ""
               || model.age == ""
               then
                ("orange", "field is required")

            else if model.password /= model.passwordAgain then
                ("red", "passwords do not match")

            else if String.length model.password < 8 then
                ("red", "password should be 8 characters at least")

            else if not (upperCaseInPWD model.password) then
                ("red", "password should contain uppercase")

            else if not (lowerCaseInPWD model.password) then
                ("red", "password should contain lowercase")

            else if not (numericInPWD model.password) then
                ("red", "password should contain digit")

            else
                case String.toInt model.age of
                    Err msg ->
                        ("red", msg)
                    Ok age ->
                        ("green", "ok")
    in
                { model | message = message, mColor = color }


upperCaseInPWD : String -> Bool
upperCaseInPWD pwd =
    let
        l = pwd
            |> String.toList
            |> List.map Char.isUpper
            |> List.filter (\x -> x)
    in
        if List.isEmpty l then
            False
        else True


lowerCaseInPWD : String -> Bool
lowerCaseInPWD pwd =
    let
        l = pwd
            |> String.toList
            |> List.map Char.isLower
            |> List.filter (\x -> x)
    in
        if List.isEmpty l then
            False
        else True


numericInPWD : String -> Bool
numericInPWD pwd =
    let
        l = pwd
            |> String.toList
            |> List.map Char.isDigit
            |> List.filter (\x -> x)
    in
        if List.isEmpty l then
            False
        else True
