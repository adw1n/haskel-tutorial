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

testWinner:: Player -> GameBoard -> Bool
testWinner player board'
  | (head board_) == winningSeq = True
  | (last board_) == winningSeq = True
  | (board_!!1) == winningSeq = True
  | diagonal1 == winningSeq = True
  | diagonal2 == winningSeq = True
  | (x1,y1,z1) == winningSeq = True
  | (x2,y2,z2) == winningSeq = True
  | (x3,y3,z3) == winningSeq = True
  | otherwise = False
  where board_ = (board board')
        winningSeq = (player, player, player)
        (x1,x2,x3) = board_!!0
        (y1,y2,y3) = board_!!1
        (z1,z2,z3) = board_!!2
        diagonal1 = (x1,y2,z3)
        diagonal2 = (x3,y2,z1)



-- Take the board and decide whether there is a winner.
-- @return: the winner (O or X) or NA if no1 has won the game yet
-- also consider doing 'error "Invalid board state"' if the board is in an invalid state
winner:: GameBoard -> Player
winner board
  | (testWinner O board) && (testWinner X board) = error "Invalid board state"
  | (testWinner O board) = O
  | (testWinner X board) = X
  | otherwise = NA


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
