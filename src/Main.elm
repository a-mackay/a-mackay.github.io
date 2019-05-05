module Main exposing (..)


import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Print
import Url exposing (Url)
import Url.Parser as UP exposing ((</>))


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , onUrlRequest = UrlRequested
    , onUrlChange = UrlChanged
    }


init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init _ url key =
  (defaultModel key, Cmd.none)


type alias Model =
  { userInput: Maybe String
  , selectedTab: Tab
  , navigationKey: Nav.Key
  }


defaultModel : Nav.Key -> Model
defaultModel key = Model Nothing IndexTab key


type Tab
  = IndexTab
  | ResumeTab
  | JsonPrettifierTab


type Msg
  = JsonSubmitted String
  | UrlRequested Browser.UrlRequest
  | UrlChanged Url


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    JsonSubmitted string ->
      ({ model | userInput = Just string }, Cmd.none)

    UrlRequested urlRequest ->
      case urlRequest of
        Browser.External string ->
          (model, Nav.load string)
        Browser.Internal url ->
          case UP.parse routeParser url of
            Just route ->
              ({ model | selectedTab = (routeToTab route) }, Nav.pushUrl model.navigationKey (Url.toString url))
            Nothing ->
              (model, Cmd.none)
              
    UrlChanged url ->
      (model, Cmd.none) -- TODO



view : Model -> Browser.Document Msg
view model =
  { title = "Prettify JSON"
  , body =
    [ h1 [] [ text "Paste in some JSON:" ]
    , pre [] [ text (Debug.toString model.selectedTab) ]
    , div [ id "input-output-div"]
      [ div [ id "input-div" ]
        [-- [ jsonInput
        -- , submitButton
        ]
      , div [ id "output-div" ]
        [ pre [ id "output" ] [ text (prettify model.userInput) ]
        ]
      , ul []
        [ viewLink "/resume"
        , viewLink "/index"
        , viewLink "/jsonprettifier"
        , viewLink "/reviews/public-opinion"
        , viewLink "/reviews/shah-of-shahs"
        ]
      ]
    ]
  }

viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]

tabs : List Tab
tabs = [IndexTab, ResumeTab, JsonPrettifierTab]


-- jsonInput : Html Msg
-- jsonInput =
--   input [ id "input", placeholder "Paste in some JSON...", onInput ChangeJson ] []


-- submitButton : Html Msg
-- submitButton =
--   button [ id "submit-button", onClick (PrettyPrintJson) ] [ text "Submit" ]


prettify : Maybe String -> String
prettify maybeJson =
  case maybeJson of
    Just json ->
      let
        config = { indent = 4, columns = 120 }
        result = Json.Print.prettyString config json
      in
        case result of
          Ok prettyJson -> prettyJson
          Err errorMsg -> errorMsg
    Nothing -> ""


type Route
  = JsonPrettifier
  | Index
  | Resume


routeParser : UP.Parser (Route -> Route) Route
routeParser =
  UP.oneOf
    [ UP.map JsonPrettifier (UP.s "jsonprettifier")
    , UP.map Index (UP.s "index")
    , UP.map Resume (UP.s "resume")
    ]


routeToTab : Route -> Tab
routeToTab route =
  case route of
    JsonPrettifier -> JsonPrettifierTab
    Index -> IndexTab
    Resume -> ResumeTab