module Main exposing (init)

import Browser
import Browser.Navigation as Navigation
import Element exposing (..)
import Json.Decode as Decode
import Page
import Page.Decree as Decree
import Page.Index as Index
import Route
import Session
import Task
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }



-- Model


type Model
    = Index Index.Model
    | Decree Decree.Model


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init () url key =
    let
        session =
            Session.fromKey key
    in
    changeRouteTo (Route.fromUrl url) (Index <| Index.init session)



-- UPDATE


type Msg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | GotIndexMsg Index.Msg
    | GotDecreeMsg Decree.Msg


toSession : Model -> Session.Session
toSession page =
    case page of
        Index index ->
            Index.toSession index

        Decree decree ->
            Decree.toSession decree


changeRouteTo : Maybe Route.Route -> Model -> ( Model, Cmd Msg )
changeRouteTo maybeRoute model =
    let
        session =
            toSession model
    in
    case maybeRoute of
        Nothing ->
            ( model, Cmd.none )

        Just Route.Index ->
            ( Index <| Index.init session, Cmd.none )

        Just Route.Decree ->
            ( Index <| Index.init session, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( ChangedUrl url, _ ) ->
            changeRouteTo (Route.fromUrl url) model

        ( ClickedLink urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Navigation.pushUrl (Session.navKey <| toSession model)
                        (Url.toString url)
                    )

                Browser.External href ->
                    ( model, Navigation.load href )

        ( GotIndexMsg subMsg, Index index ) ->
            ( Index <| Index.update subMsg index, Cmd.none )

        ( GotDecreeMsg subMsg, Decree decree ) ->
            ( Decree <| Decree.update subMsg decree, Cmd.none )

        ( _, _ ) ->
            -- Disregard messages that arrived for the wrong page
            ( model, Cmd.none )


updateWith :
    (subModel -> Model)
    -> (subMsg -> Msg)
    -> ( subModel, Cmd subMsg )
    -> ( Model, Cmd Msg )
updateWith toModel toMsg ( subModel, subCmd ) =
    ( toModel subModel, Cmd.map toMsg subCmd )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        viewPage :
            (msg -> Msg)
            -> { title : String, content : Element msg }
            -> Browser.Document Msg
        viewPage toMsg config =
            Page.view config toMsg
    in
    case model of
        Index index ->
            Index.view index
                |> viewPage GotIndexMsg

        Decree decree ->
            Decree.view decree
                |> viewPage GotDecreeMsg



-- Subscriptions


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
