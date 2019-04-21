import Browser
import Html exposing (..)


main : Program () Model Msg
main = Browser.document
    { init = init
    , view = view
    , update = update
    , subscriptions = (\_ -> Sub.none)
    }


init : () -> (Model, Cmd Msg)
init _ = (Model "Hello world", Cmd.none)


type alias Model =
    { string: String
    }


type Msg
    = DoNothing


update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)


view : Model -> Browser.Document Msg
view model =
    { title = "Title"
    , body = [ h1 [] [ text model.string ] ]
    }