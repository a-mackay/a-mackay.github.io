import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Print


main : Program () Model Msg
main = Browser.document
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }


init : () -> (Model, Cmd Msg)
init _ = (Model Nothing Nothing, Cmd.none)


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