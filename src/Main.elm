module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
main =
  Browser.sandbox { init = init, update = update, view = view }

type Msg = Click Int

type Player = Naughty | Crossy
type Square = Blank | Naught | Cross

type alias Grid = List Square
type alias Model = { grid: Grid, player: Player }

init = { grid = List.repeat 9 Blank, player = Naughty }

getSquare: Player -> Square
getSquare player =
  if (player == Naughty) then Naught else Cross

update: Msg -> Model -> Model
update msg model =
  case msg of
    Click index -> 
      { 
        grid = (List.take index model.grid) ++ [getSquare model.player] ++ (List.drop (index + 1) model.grid),
        player = if (model.player == Naughty) then Crossy else Naughty
      }

updateGrid: Grid -> Grid
updateGrid model =
  List.repeat 9 Cross

viewSquare: Int -> Square -> Html Msg
viewSquare index square =
  let 
    childElements =
      if modBy 3 (index + 1) == 0 then
        [br [] []]
      else
        []
  in

  case square of
    Blank ->
        span [ onClick (Click index) ] ([ text "⬛️" ] ++ childElements)
    Cross ->
      span [] ([ text "❌" ] ++ childElements)
    Naught ->
      span [] ([ text "🔴" ] ++ childElements)

view: Model -> Html Msg
view model =
  div [
    style "height" "100vh",
    style "width" "100vw",
    style "display" "flex",
    style "justify-content" "center",
    style "align-items" "center"]
    [ div []
      (List.indexedMap viewSquare model.grid) ]
  