module Main exposing (..)


import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Print
import Url exposing (Url)
import Url.Parser exposing ((</>))


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    , onUrlRequest = Debug.todo "todo"
    , onUrlChange = Debug.todo "todo"
    }


init : () -> Url -> Nav.Key -> (Model, Cmd Msg)
init _ url key = (Model Nothing Nothing, Cmd.none)


type alias Model =
  { userInput: Maybe String
  , json: Maybe String
  }


type Msg
  = ChangeJson String
  | PrettyPrintJson


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangeJson string ->
      ({ model | userInput = Just string }, Cmd.none)
    PrettyPrintJson ->
      ({ model | json = model.userInput }, Cmd.none)



view : Model -> Browser.Document Msg
view model =
  { title = "Prettify JSON"
  , body =
    [ h1 [] [ text "Paste in some JSON:" ]
    , div [ id "input-output-div"]
      [ div [ id "input-div" ]
        [ jsonInput
        , submitButton
        ]
      , div [ id "output-div" ]
        [ pre [ id "output" ] [ text (prettify model.json) ]
        ]
      ]
    ]
  }


jsonInput : Html Msg
jsonInput =
  input [ id "input", placeholder "Paste in some JSON...", onInput ChangeJson ] []


submitButton : Html Msg
submitButton =
  button [ id "submit-button", onClick (PrettyPrintJson) ] [ text "Submit" ]


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


routeParser : Url.Parser.Parser (Route -> a) a
routeParser =
  let
    oneOf = Url.Parser.oneOf
    map = Url.Parser.map
    s = Url.Parser.s
  in
    oneOf
      [ map JsonPrettifier (s "tools" </> s "jsonprettifier")
      , map Index (s "index")
      , map Resume (s "resume")
      ]