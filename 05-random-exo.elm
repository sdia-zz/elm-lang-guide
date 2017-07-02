import Html exposing (..)
import Html.Events exposing (onClick)
-- import Html.Attributes exposing (attribute, class, style, src, width, height)
import Html.Attributes exposing (src)

import Random
import String






main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model =
    { dieFace : Int
    }


init : (Model, Cmd Msg)
init =
    (Model 1, Cmd.none)


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            (model, Random.generate NewFace (Random.int 1 6))

        NewFace nf ->
            (Model nf, Cmd.none)

-- <img src="pic_mountain.jpg" alt="Mountain View" style="width:304px;height:228px;">
view : Model -> Html Msg
view model =
    div []
     [ img [src (getDieUrl model.dieFace) ] []
     , h1 [] [ text (toString model.dieFace) ]
     , button [ onClick Roll ] [ text "Roll" ]
     ]

subscriptions : Model -> Sub Msg
subscriptions model =
              Sub.none


getDieUrl : Int -> String
getDieUrl n =
        "https://www.wpclipart.com/recreation/games/dice/die_face_"
        ++ toString n
        ++ ".png"


{-
    https://www.wpclipart.com/recreation/games/dice/die_face_1.png
    https://www.wpclipart.com/recreation/games/dice/die_face_2.png
    https://www.wpclipart.com/recreation/games/dice/die_face_3.png
    https://www.wpclipart.com/recreation/games/dice/die_face_4.png
    https://www.wpclipart.com/recreation/games/dice/die_face_5.png
    https://www.wpclipart.com/recreation/games/dice/die_face_6.png
-}
