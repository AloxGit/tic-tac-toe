import 'dart:math';

int player=1;
String char='x', opponent='o';
bool gameOver=false;
String gameResult='';
List board = [
  ['_', '_', '_'],
  ['_', '_', '_'],
  ['_', '_', '_'],
];


int winningMove() {
  for (int i = 0; i<3; i++) {
    if(board[i][0]==board[i][1] && board[i][0]==opponent && board[i][2]=='_')
      return 3*i+2;
    if(board[i][0]==board[i][2] && board[i][0]==opponent && board[i][1]=='_')
      return 3*i+1;
    if(board[i][2]==board[i][1] && board[i][1]==opponent && board[i][0]=='_')
      return 3*i;
  }
  for (int i = 0; i<3; i++) {
    if(board[0][i]==board[1][i] && board[0][i]==opponent && board[2][i]=='_')
      return 6+i;
    if(board[0][i]==board[2][i] && board[0][i]==opponent && board[1][i]=='_')
      return 3+i;
    if(board[2][i]==board[1][i] && board[1][i]==opponent && board[0][i]=='_')
      return i;
  }
  if(board[0][0]==board[1][1] && board[0][0]==opponent && board[2][2]=='_')
    return 8;
  if(board[2][2]==board[1][1] && board[1][1]==opponent && board[0][0]=='_')
    return 0;
  if(board[0][0]==board[2][2] && board[0][0]==opponent && board[1][1]=='_')
    return 4;

  if(board[0][2]==board[1][1] && board[1][1]==opponent && board[2][0]=='_')
    return 6;
  if(board[2][0]==board[1][1] && board[1][1]==opponent && board[0][2]=='_')
    return 2;
  if(board[0][2]==board[2][0] && board[2][0]==opponent && board[1][1]=='_')
    return 4;
  return 10;
}



bool isWinning()
{
  for (int i = 0; i<3; i++) {
    if(board[i][0]==board[i][1] && board[i][0]==board[i][2] && board[i][0]!='_')
      return true;
  }
  for (int i = 0; i<3; i++) {
    if(board[0][i]==board[1][i] && board[0][i]==board[2][i] && board[0][i]!='_')
      return true;
  }
  if(board[0][0]==board[1][1] && board[0][0]==board[2][2] && board[0][0]!='_')
    return true;
  if(board[0][2]==board[1][1] && board[0][2]==board[2][0] && board[2][0]!='_')
    return true;

  return false;
}

bool isMovesLeft()
{
  for (int i = 0; i<3; i++)
    for (int j = 0; j<3; j++)
      if (board[i][j]=='_')
        return true;
  return false;
}


int evaluate(var b)
{
  for (int row = 0; row<3; row++)
  {
    if (b[row][0]==b[row][1] &&
        b[row][1]==b[row][2])
    {
      if (b[row][0]==opponent)
        return 10;
      else if (b[row][0]==char)
        return -10;
    }
  }
  for (int col = 0; col<3; col++)
  {
    if (b[0][col]==b[1][col] &&
        b[1][col]==b[2][col])
    {
      if (b[0][col]==opponent)
        return 10;

      else if (b[0][col]==char)
        return -10;
    }
  }
  if (b[0][0]==b[1][1] && b[1][1]==b[2][2])
  {
    if (b[0][0]==opponent)
      return 10;
    else if (b[0][0]==char)
      return -10;
  }
  if (b[0][2]==b[1][1] && b[1][1]==b[2][0])
  {
    if (b[0][2]==opponent)
      return 10;
    else if (b[0][2]==char)
      return -10;
  }
return 0;
}


int minimax(int depth, bool isMax)
{
  int score = evaluate(board);

  if (score == 10)
    return score;

  if (score == -10)
    return score;

  if (isMovesLeft()==false)
    return 0;

  if (isMax)
  {
    int best = -1000;

    for (int i = 0; i<3; i++)
    {
      for (int j = 0; j<3; j++)
      {

        if (board[i][j]=='_')
        {

          board[i][j] = opponent;

          best = max( best, minimax(depth+1, !isMax) );

          board[i][j] = '_';
        }
      }
    }
    return best;
  }


  else
  {
    int best = 1000;


    for (int i = 0; i<3; i++)
    {
      for (int j = 0; j<3; j++)
      {

        if (board[i][j]=='_')
        {

          board[i][j] = char;

          best = min(best,
              minimax(depth+1, !isMax));

          board[i][j] = '_';
        }
      }
    }
    return best;
  }
}

int findBestMove()
{
  int bestVal = -1000;

  int x = -1;
  int y = -1;


  for (int i = 0; i<3; i++)
  {
    for (int j = 0; j<3; j++)
    {

      if (board[i][j]=='_')
      {

        board[i][j] = opponent;

        int moveVal = minimax(0, false);

        board[i][j] = '_';

        if (moveVal > bestVal)
        {
          x = i;
          y = j;
          bestVal = moveVal;
        }
      }
    }
  }


  print(x);
  print(y);

  return 3*x+y;
}