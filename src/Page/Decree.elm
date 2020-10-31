module Page.Decree exposing (Model, Msg, init, toSession, update, view)

import Element exposing (..)
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


view : Model -> { title : String, content : Element Msg }
view model =
    { title = "Decree"
    , content =
        image []
            { src = "static/img/under-construction.gif"
            , description = "Under Construction"
            }
    }



-- EXPORT


toSession : Model -> Session.Session
toSession model =
    model.session
