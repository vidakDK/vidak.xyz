module Page.Index exposing (Model, Msg, init, toSession, update, view)

import Element exposing (..)
import Element.Events as Events
import Element.Font as Font
import Page
import Session



-- MODEL


type alias Model =
    { activeLink : Maybe String
    , session : Session.Session
    }


init : Session.Session -> Model
init session =
    Model Nothing session



-- UPDATE


type Msg
    = HoveredLink String
    | UnHoveredLink


update : Msg -> Model -> Model
update msg model =
    case msg of
        HoveredLink link ->
            { model | activeLink = Just link }

        UnHoveredLink ->
            { model | activeLink = Nothing }



-- VIEW


edges =
    { top = 0, bottom = 0, left = 0, right = 0 }


view : Model -> { title : String, content : Element Msg }
view model =
    let
        link =
            viewLink model.activeLink
    in
    { title = "Home"
    , content =
        textColumn [ alignTop, spacing 20 ]
            [ paragraph [ Font.size 28, Font.bold ] [ text "Hello" ]
            , paragraph []
                [ image []
                    { src = "static/img/cogs.gif"
                    , description = "cogs"
                    }
                ]
            ]
    }


viewLink : Maybe String -> String -> String -> Element Msg
viewLink activeLink url page =
    let
        baseAttributes =
            [ Font.color Page.colors.link
            , Events.onMouseEnter (HoveredLink page)
            , Events.onMouseLeave UnHoveredLink
            ]

        attributes =
            case activeLink of
                Just link ->
                    if link == page then
                        Font.underline :: baseAttributes

                    else
                        baseAttributes

                Nothing ->
                    baseAttributes
    in
    link attributes { url = url, label = text page }



-- EXPORT


toSession : Model -> Session.Session
toSession model =
    model.session
