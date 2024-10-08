module MainTest exposing (..)

import Expect
import Test exposing (..)
import Main

suite : Test
suite =
    describe "Main module"
        [ test "init returns empty model" <|
            \_ ->
                let
                    (initialModel, _) =
                        Main.init ()
                in
                Expect.equal initialModel {}
        ]
