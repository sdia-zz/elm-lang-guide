import Html exposing (..)
import Html.Events exposing (onClick)
-- import Html.Attributes exposing (attribute, class, style, src, width, height)
import Html.Attributes exposing (src)

import Random
import String

import Svg
import Svg.Attributes as SvgA



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model =
    { dieFace1 : Int
    , dieFace2 : Int
    }


init : (Model, Cmd Msg)
init =
    (Model 1 1, Cmd.none)


type Msg
    = Roll
    | NewFace Int Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            (model,
             Random.map2 (,) (Random.int 1 6) (Random.int 1 6)
             |> Random.generate (uncurry NewFace))

        NewFace x y ->
            ({model | dieFace1=x, dieFace2=y}, Cmd.none)


view : Model -> Html Msg
view model =
    div []
     [ img [src (getDieUrl model.dieFace1) ] []
     , img [src (getDieUrl model.dieFace2) ] []
     -- , h1 [] [ text (toString model.dieFace) ]
     , button [ onClick Roll ] [ text "Roll" ]

     -- Need to learn about SVG first...
     , Svg.svg
      [ SvgA.width "120", SvgA.height "120", SvgA.viewBox "0 0 120 120" ]
      [ Svg.rect [ SvgA.x "10", SvgA.y "10", SvgA.width "100", SvgA.height "100", SvgA.rx "15", SvgA.ry "15" ] [] ]
     ]

subscriptions : Model -> Sub Msg
subscriptions model =
              Sub.none


getDieUrl : Int -> String
getDieUrl n =
        "https://www.wpclipart.com/recreation/games/dice/die_face_"
        ++ toString n
        ++ ".png"
