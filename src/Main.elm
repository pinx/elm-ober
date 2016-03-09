module ElmOber where

import StartApp
import Task exposing (Task)
import Signal exposing (Signal, Address)
import Effects exposing (Effects, Never)
import Html exposing (..)
import Html.Attributes exposing (..)

--
-- StartApp boilerplate
--
app =
    StartApp.start {
      init = init,
      view = view,
      update = update,
      inputs = []
    }

main : Signal Html
main =
    app.html

port tasks : Signal (Task Never ())
port tasks =
    app.tasks

--
-- My type declarations
--
type alias Model = { name : String, categories : List Category }

type alias Category = { name : String }

type Action = NoOp

initialModel : Model
initialModel = 
  { name = "Menu", categories = 
    [ { name = "Drinks" }
    , { name = "Food" }
    ] }
--
-- My functions
--
init : (Model, Effects Action)
init = ( initialModel, Effects.none)

update : Action -> Model -> (Model, Effects Action)
update action model = 
    case action of
          NoOp -> (model, Effects.none)

view : Address Action -> Model -> Html
view address model = 
  div
    [ class "content" ]
    [ header
        []
        [ h1 [] [ text "Elm Ober" ]
        , span [ class "tagline" ] [ text model.name ]
        ]
    , ul
        [ class "results" ]
        (List.map (categoryView) model.categories)
    ]

categoryView : Category -> Html
categoryView category = 
  li
    []
    [ text category.name ]

