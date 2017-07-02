--Model
type alias Model =
    { ...
    }

--Update
type Msg = Submit | ...

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    ...


--View
view : Model -> Html Msg
view model =
    div [] [] ...


--Subscriptions
subscriptions Model -> Sub Msg
subscriptions model =
    ...


-- INIT
init : (Model, Cmd Msg)
init =
    ...
