module Page.Decree exposing (Model, Msg, init, toSession, update, view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Session



-- MODEL


type alias Model =
    { session : Session.Session
    , courses : List Course
    }


type alias Course =
    { name : String
    , link : String
    , progress : Int
    , grade : String
    , year : String
    }


initialModel : Session.Session -> Model
initialModel session =
    { session = session
    , courses =
        [ { name = "MIT 6.006: Introduction to Algorithms"
          , link = "https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-006-introduction-to-algorithms-fall-2011/"
          , progress = 20
          , grade = ""
          , year = "2021"
          }
        , { name = "NVIDIA: Fundamentals of Accelerated Computing with CUDA C/C++"
          , link = "https://courses.nvidia.com/courses/course-v1:DLI+C-AC-01+V1/info"
          , progress = 25
          , grade = ""
          , year = "2021"
          }
        , { name = "Shanghai Jiao Tong University: Mandarine Chinese 1"
          , link = "https://www.coursera.org/learn/mandarin-chinese-1/home/welcome"
          , progress = 60
          , grade = ""
          , year = "2021"
          }
        , { name = "MIT 6.86x: Machine Learning with Python"
          , link = "https://learning.edx.org/course/course-v1:MITx+6.86x+3T2020/home"
          , progress = 100
          , grade = "99%"
          , year = "2020"
          }
        , { name = "Stanford CS231n: Convolutional Neural Networks"
          , link = "http://cs231n.stanford.edu/syllabus.html"
          , progress = 15
          , grade = ""
          , year = "2019"
          }
        , { name = "Stanford CS234: Reinforcement Learning"
          , link = "http://web.stanford.edu/class/cs234/index.html"
          , progress = 5
          , grade = ""
          , year = "2019"
          }
        , { name = "MIT 6.341x: Discrete-Time Signal Processing"
          , link = "https://learning.edx.org/course/course-v1:MITx+6.341x_2+2T2016/home"
          , progress = 5
          , grade = ""
          , year = "2019"
          }
        ]
    }


init : Session.Session -> Model
init session =
    initialModel session



-- UPDATE


type Msg
    = Ignored


update : Msg -> Model -> Model
update msg model =
    case msg of
        Ignored ->
            model



-- VIEW


colours =
    { primary = rgb 0.2 0.72 0.91
    , success = rgb 0.275 0.533 0.278 -- #468847
    , info = rgb 0.227 0.529 0.678 -- #3a87ad
    , important = rgb 0.729 0.29 0.282 -- #b94a48
    , warning = rgb 0.8 0.2 0.2
    , link = rgb 0.361 0.502 0.737
    , darkGrey = rgb 0.212 0.212 0.216
    , white = rgb 0.99 0.99 0.973
    }


view : Model -> { title : String, content : Element Msg }
view model =
    { title = "Learning"
    , content =
        viewCourses model.courses
    }


viewCourses : List Course -> Element Msg
viewCourses courses =
    column [ spacing 10 ] <| List.map viewCourse courses


viewCourse : Course -> Element Msg
viewCourse course =
    row [ spacing 10 ]
        [ viewProgress course.progress
        , viewName course.name course.link

        --, text course.grade
        , text course.year
        ]


viewName : String -> String -> Element Msg
viewName name url =
    link [] { url = url, label = el [ Font.color colours.link ] <| text name }


viewProgress : Int -> Element Msg
viewProgress progress =
    let
        maxWidth =
            500

        maxHeight =
            50

        doneWidth =
            progress * maxWidth // 100

        fontColour =
            if progress < 5 then
                colours.darkGrey

            else
                colours.white

        donePart =
            el
                [ height <| px maxHeight
                , width <| px doneWidth
                , Background.color colours.success
                , Font.color fontColour
                ]
            <|
                text <|
                    String.fromInt progress
                        ++ "%"
    in
    if progress < 100 then
        row []
            [ donePart
            , el
                [ height <| px maxHeight
                , width <| px (maxWidth - doneWidth)
                , Border.width 1
                ]
                none
            ]

    else
        donePart



-- EXPORT


toSession : Model -> Session.Session
toSession model =
    model.session
