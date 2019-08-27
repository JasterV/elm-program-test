module TestHelper exposing (testAssertion2)

import Expect exposing (Expectation)
import Html
import Html.Events exposing (onClick)
import Json.Decode
import ProgramTest exposing (ProgramTest)
import SimulatedEffect.Cmd
import SimulatedEffect.Http as Http
import SimulatedEffect.Task as Task
import Test exposing (..)
import Test.Expect exposing (expectFailure, expectSuccess)
import Test.Http



-- Test assertion helpers
--
-- These helpers make it easier to write tests that check both the expect* and ensure*
-- versions of an assertion.


testAssertion2 :
    (a -> b -> ProgramTest model msg effect -> Expectation)
    -> (a -> b -> ProgramTest model msg effect -> ProgramTest model msg effect)
    -> String
    -> (String -> (a -> b -> ProgramTest model msg effect -> Expectation) -> Expectation)
    -> Test
testAssertion2 expect ensure name go =
    describe name
        [ test "expect" <|
            \() ->
                go "expect" expect
        , test "ensure" <|
            \() ->
                go "ensure" (\a b -> ensure a b >> ProgramTest.done)
        ]
