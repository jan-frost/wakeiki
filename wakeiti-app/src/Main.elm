module Main exposing (main, init, update, view, Model, Msg(..))

import Browser
import Html exposing (Html, div, text, h1, p)
import Html.Attributes exposing (style)

type alias Model =
    {}

init : () -> (Model, Cmd Msg)
init _ =
    ({}, Cmd.none)

type Msg
    = NoOp

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NoOp ->
            (model, Cmd.none)

view : Model -> Html Msg
view model =
    div [ style "padding" "20px" ]
        [ h1 [ style "color" "blue" ] [ text "Hello, Elm Android App!" ]
        , p [] [ text "If you can see this, the Elm app is working correctly." ]
        ]

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
