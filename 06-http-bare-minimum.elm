--Model
type alias Model =
    { topic : String
    , gifUrl : String
    }

init : (Model, Cmd Msg)
init =
    (Model "cats" "waiting.gif", Cmd.none)


--Update
type Msg = MorePlease

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        MorePlease ->
            (model, Cmd.none)


--View
view : Model -> Html Msg
view model =
    div []
     [ h2 [] [ text model.topic ]
     , img [src model.gifUrl] []
     , button [ onClick MorePlease ] [ text "More Please!" ]
     ]            
