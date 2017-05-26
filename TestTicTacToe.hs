--module TestTickTacToe where
import Test.HUnit
import Control.Exception
import Control.Monad
import TicTacToe

-- assertRaises is missinging in the HUnit module, so we roll our own solution
-- author: https://stackoverflow.com/a/6147930
assertException :: (Exception e, Eq e) => e -> IO a -> IO ()
assertException ex action =
    handleJust isWanted (const $ return ()) $ do
        action
        assertFailure $ "Expected exception: " ++ show ex
  where isWanted = guard . (== ex)

test_X_wins = do
    TestCase (assertEqual "" TicTacToe.X (TicTacToe.winner board) )
  where
    board = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.NA,TicTacToe.NA),
                                    (TicTacToe.O, TicTacToe.X, TicTacToe.O),
                                    (TicTacToe.NA,TicTacToe.O, TicTacToe.X)]


test_O_wins = do
    TestCase (assertEqual "" TicTacToe.O (TicTacToe.winner board) )
  where
    board = TicTacToe.GameBoard  [(TicTacToe.O, TicTacToe.X, TicTacToe.NA),
                                    (TicTacToe.X, TicTacToe.O, TicTacToe.X),
                                    (TicTacToe.X, TicTacToe.O, TicTacToe.O)]

test_empty_board = do
    TestCase (assertEqual "" TicTacToe.NA (TicTacToe.winner board) )
   where
     board = TicTacToe.GameBoard  [(TicTacToe.NA, TicTacToe.NA, TicTacToe.NA),
                                     (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA),
                                     (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA)]


test_invalid_board_both_players_won = do
  TestCase $ assertException (ErrorCall "Invalid board state") (evaluate (TicTacToe.winner board))
 where
   board = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.X, TicTacToe.X),
                                   (TicTacToe.O, TicTacToe.O, TicTacToe.O),
                                   (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA)]

test_invalid_board_too_many_pawns = do
  TestCase $ assertException (ErrorCall "Too many pawns") (evaluate (TicTacToe.winner board))
 where
   board = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.X, TicTacToe.NA),
                                 (TicTacToe.X, TicTacToe.X, TicTacToe.O),
                                 (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA)]
-- using depreciated testpack
-- import Test.HUnit.Tools
-- test_invalid_board = do
--    TestCase (assertRaises "" (ErrorCall "Invalid board state") (evaluate (TicTacToe.winner board)) )
--   where
--     board = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.X, TicTacToe.X),
--                                     (TicTacToe.O, TicTacToe.O, TicTacToe.O),
--                                     (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA)]


test_doMove_changes_board = do
  TestCase (assertBool "" (board/=(TicTacToe.doMove TicTacToe.X  board)) )
 where
   board = TicTacToe.GameBoard  [(TicTacToe.NA, TicTacToe.NA, TicTacToe.NA),
                                   (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA),
                                   (TicTacToe.NA, TicTacToe.NA, TicTacToe.NA)]

test_doMove_makes_the_best_move = do
  TestCase (assertEqual "" expectedOutputBoard (TicTacToe.doMove TicTacToe.X inputBoard) )
 where
   inputBoard = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.NA,TicTacToe.NA),
                                      (TicTacToe.NA,TicTacToe.X, TicTacToe.NA),
                                      (TicTacToe.O, TicTacToe.O, TicTacToe.NA)]
   expectedOutputBoard = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.NA,TicTacToe.NA),
                                               (TicTacToe.NA,TicTacToe.X, TicTacToe.NA),
                                               (TicTacToe.O, TicTacToe.O, TicTacToe.X)]



test_doMove_does_not_make_loosing_move = do
  TestCase (assertEqual "l2p" expectedOutputBoard (TicTacToe.doMove TicTacToe.X inputBoard) )
 where
   inputBoard = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.O,TicTacToe.NA),
                                      (TicTacToe.X,TicTacToe.X, TicTacToe.NA),
                                      (TicTacToe.O, TicTacToe.X, TicTacToe.O)]
   expectedOutputBoard = TicTacToe.GameBoard  [(TicTacToe.X, TicTacToe.O,TicTacToe.NA),
                                               (TicTacToe.X,TicTacToe.X, TicTacToe.O),
                                               (TicTacToe.O, TicTacToe.X, TicTacToe.O)]


tests = do
  TestList ([
    TestLabel "check winner = X wins" test_X_wins,
    TestLabel "check winner = O wins" test_O_wins,
    TestLabel "check winner on an empty board" test_empty_board,
    TestLabel "check invalid board - both players won at the same time" test_invalid_board_both_players_won,
    TestLabel "check invalid board - player X has too many pawns" test_invalid_board_too_many_pawns
    ]++[
     TestLabel "doMove changes the board" test_doMove_changes_board,
     TestLabel "doMove picks up the best move" test_doMove_changes_board,
     TestLabel "doMove isn't stupid" test_doMove_does_not_make_loosing_move
    ]
   )
main = runTestTT tests
