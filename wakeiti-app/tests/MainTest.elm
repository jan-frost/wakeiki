module MainTest exposing (..)

import Expect
import Test exposing (..)
import Main
import Html
import Test.Html.Query as Query
import Test.Html.Selector as Selector

suite : Test
suite =
    describe "Main module"
        [ test "init should return an empty model and no command" <|
            \_ ->
                let
                    (initialModel, initialCmd) = Main.init ()
                in
                Expect.equal (initialModel, initialCmd) ({}, Cmd.none)
        , test "update should return the same model for NoOp" <|
            \_ ->
                let
                    (updatedModel, cmd) = Main.update Main.NoOp {}
                in
                Expect.equal (updatedModel, cmd) ({}, Cmd.none)
        , test "view should contain expected text" <|
            \_ ->
                Main.view {}
                    |> Query.fromHtml
                    |> Query.has [ Selector.text "Hello, Elm Android App!" ]
        ]
