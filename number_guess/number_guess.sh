#! /bin/bash  

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USERNAME_CHECK=$($PSQL "SELECT usernames FROM player_info WHERE usernames='$USERNAME'")

if [[ -z $USERNAME_CHECK ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INITIAL_INSERT=$($PSQL "INSERT INTO player_info(usernames, games_played, best_game) VALUES('$USERNAME', 0, 0)")
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM player_info WHERE usernames='$USERNAME_CHECK'")
  BEST_GAME=$($PSQL "SELECT best_game FROM player_info WHERE usernames='$USERNAME_CHECK'")
  USERNAME_WHY=$($PSQL "SELECT usernames FROM player_info WHERE usernames='$USERNAME_CHECK'")
  echo "Welcome back, $USERNAME_WHY! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

echo "Guess the secret number between 1 and 1000:"
read NUMBER_GUESS
RANDOM_INT=$[ $RANDOM % 100 + 1 ]
COUNTER=1;

DATABASE_INSERTION() {

  if [[ -z $USERNAME_CHECK ]]   #IF USERNAME IS NOT IN DB ALREADY
  then
    AMOUNT_GAMES_PLAYED=1
    BEST_GAME_PLAYED=$COUNTER
    ADD_USER=$($PSQL "UPDATE player_info SET games_played=$AMOUNT_GAMES_PLAYED, best_game=$BEST_GAME_PLAYED WHERE usernames='$USERNAME'")
  else
    UPDATE_GAME_AMOUNT=$($PSQL "SELECT games_played FROM player_info WHERE usernames='$USERNAME_CHECK'")
    UPDATE_GAME_AMOUNT=$((UPDATE_GAME_AMOUNT+1))
    GET_BEST_GAME=$($PSQL "SELECT best_game FROM player_info WHERE usernames='$USERNAME_CHECK'")
    if [[ $COUNTER < $GET_BEST_GAME ]]
    then
      GET_BEST_GAME=$COUNTER
    fi
    UPDATE_USER=$($PSQL "UPDATE player_info SET games_played=$UPDATE_GAME_AMOUNT, best_game=$GET_BEST_GAME WHERE usernames='$USERNAME_CHECK'")
  fi
}

GUESS_FUNCTION() {

  #Check if input is integer
  if ! [[ $1 =~ ^[0-9]+$ ]]
  then
        echo "That is not an integer, guess again:"
        read NUMBER_GUESS
        GUESS_FUNCTION $NUMBER_GUESS
        return 0;
  fi

  if [[ $1 == $RANDOM_INT ]]
  then
    echo "You guessed it in $COUNTER tries. The secret number was $RANDOM_INT. Nice job!"
    DATABASE_INSERTION
  elif [[ $1 > $RANDOM_INT ]]
  then
    echo "It's lower than that, guess again:"
    COUNTER=$((COUNTER+1))
    read NUMBER_GUESS
    GUESS_FUNCTION $NUMBER_GUESS
  else
    echo "It's higher than that, guess again:"
    COUNTER=$((COUNTER+1))
    read NUMBER_GUESS
    GUESS_FUNCTION $NUMBER_GUESS
  fi
}
GUESS_FUNCTION $NUMBER_GUESS
