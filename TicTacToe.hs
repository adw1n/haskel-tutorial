module TicTacToe
(
  GameBoard(..)
, Player(..)
, winner
, doMove
, parseInput
, printBoard
) where

-- NA == N/A == no player
data Player = O | X | NA deriving(Enum, Show, Eq)

data GameBoard = GameBoard {
  board:: [(Player, Player, Player)]
} deriving (Show, Eq)


-- TODO
-- Take the board and decide whether there is a winner.
-- @return: the winner (O or X) or NA if no1 has won the game yet
-- also consider doing 'error "Invalid board state"' if the board is in an invalid state
winner:: GameBoard -> Player
winner board = NA


-- TODO
-- make a move
-- @param player: make a move as the provided player
-- @return: the board state after you are done with your move
doMove:: Player -> GameBoard -> GameBoard
doMove player board = board
-- the winner function might help you here with choosing the best move to make



-- parseInput:: (String, String, String)  -> [(Player,Player,Player)]
parseInput input_ = do
  let (r1,r2,r3) = input_
  return [(getPlayerType (r1!!0), getPlayerType (r1!!1), getPlayerType (r1!!2)),
          (getPlayerType (r2!!0), getPlayerType (r2!!1), getPlayerType (r2!!2)),
          (getPlayerType (r3!!0), getPlayerType (r3!!1), getPlayerType (r3!!2))]
  where
    getPlayerType:: Char -> Player
    getPlayerType c
      | c=='X' = X
      | c=='O' = O
      | otherwise = NA


-- TODO
printBoard board'= do
  print board'
