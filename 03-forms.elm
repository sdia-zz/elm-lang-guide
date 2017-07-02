import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)




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
    }


model : Model
model =
    Model "" "" ""


type Msg =
    Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name n ->
            { model | name = n }

        Password pwd ->
            { model | password = pwd}

        PasswordAgain pwda ->
            { model | passwordAgain = pwda }


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text",     placeholder "Name",              onInput Name          ] []
        , input [ type_ "password", placeholder "Password",          onInput Password      ] []
        , input [ type_ "password", placeholder "Re-enter password", onInput PasswordAgain ] []
        , viewValidation model
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        (color, message)=
            if model.password == model.passwordAgain then
                ("green", "OK")
            else
                ("red", "passwords do not match!")
    in
        div [style [("color", color)] ] [ text message ]
