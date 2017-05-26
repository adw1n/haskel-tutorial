import TicTacToe


readBoard :: IO (String, String, String)
readBoard = do
  r1 <- getLine
  r2 <- getLine
  r3 <- getLine
  return (r1,r2,r3)

gameLoop = do
  putStrLn "Make a move (you are the X player):"
  inputBoard <- readBoard
  board' <- TicTacToe.parseInput inputBoard
  let board = TicTacToe.GameBoard board'
  let winner = TicTacToe.winner board
  if (winner==TicTacToe.NA)
    then do
      let newBoard = TicTacToe.doMove TicTacToe.O board
      putStrLn "AI move:"
      TicTacToe.printBoard newBoard
      gameLoop
  else
    print winner

main = do
  putStrLn "Shall we play a game?"
  putStrLn "Make moves by providing the new board state, e.g. current board state:"
  putStrLn "__X\n_O_\n___\nyour move (your input):\n__X\n_O_\nX__\n"
  putStrLn "Current board state:\n___\n___\n___\n"
  gameLoop
  return ()
