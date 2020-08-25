module Main exposing (init)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Events as Events
import Element.Font as Font


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { title : String
    , h1 : String
    }


initialModel : Model
initialModel =
    { title = "Vidak"
    , h1 = "Vidak"
    }


init : () -> ( Model, Cmd msg )
init _ =
    ( initialModel, Cmd.none )



-- Update


type Msg
    = Ignored


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Ignored ->
            ( model, Cmd.none )



-- View


edges =
    { top = 0, right = 0, bottom = 0, left = 0 }


colors =
    { primary = rgb 0.2 0.72 0.91
    , success = rgb 0.275 0.533 0.278
    , warning = rgb 0.8 0.2 0.2
    , link = rgb 0.361 0.502 0.737
    , black = rgb 0.05 0.05 0.05
    , darkgrey = rgb 0.31 0.31 0.31
    , lightgrey = rgb 0.733 0.733 0.733
    , white = rgb 0.99 0.99 0.99
    }


view : Model -> Browser.Document Msg
view model =
    Browser.Document model.title
        [ layout
            [ Font.color colors.darkgrey
            , Font.family [ Font.typeface "Georgia", Font.serif ]
            , paddingEach { edges | top = 20, left = 30, right = 30 }
            , Background.color colors.white
            ]
          <|
            column [ width fill, spacing 25 ]
                [ viewPageHeading model.h1
                , image []
                    { src = "static/img/under-construction.gif"
                    , description = "Under Construction"
                    }
                ]
        ]


viewPageHeading : String -> Element msg
viewPageHeading heading =
    el
        [ Font.size 40
        , Font.heavy
        , paddingEach { edges | bottom = 10 }
        ]
        (text heading)



-- Subscriptions


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
