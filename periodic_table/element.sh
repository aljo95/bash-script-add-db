#! /bin/bash

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#ATOMIC_NUMBER=$($PSQL "Select atomic_number FROM elements WHERE atomic_number=$1 OR symbol='$1' OR name='$1'")
#GET_NAME_QUERY = "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER"





NR_RE='^[0-9]+$'
if [[ $1 =~ $NR_RE ]]     # if $1 is a number
then
  #echo "You picked the element with atomic number: $1"
  ATOMIC_NUMBER=$($PSQL "Select atomic_number FROM elements WHERE atomic_number=$1")
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
    exit
  fi
  #echo $ATOMIC_NUMBER
  GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  #echo $GET_NAME
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  #echo $GET_SYMBOL
  #GET_TYPE=$($PSQL "SELECT type FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  
  #get type from join of properties and types with type_id f_key column
  GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id=properties.type_id WHERE atomic_number=$ATOMIC_NUMBER")
  #GET_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  #GET_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$GET_TYPE_ID")
  #echo $GET_TYPE

  #echo $GET_TYPE
  GET_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  #echo $GET_MASS
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  #echo $MELTING_POINT
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  #echo $BOILING_POINT


  echo "The element with atomic number $ATOMIC_NUMBER is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_MASS amu. $GET_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."



else
  N=${#1}   #gets length of string
  #echo "length of string is $N"
  if [[ $N -gt 2 ]] #if length is bigger than 2 = name, 3 or more
  then
    #echo "You picked the element with the name: $1"
    ATOMIC_NUMBER=$($PSQL "Select atomic_number FROM elements WHERE name='$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
      exit
    fi
    #echo $ATOMIC_NUMBER

    GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_NAME
    GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_SYMBOL
    GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id=properties.type_id WHERE atomic_number=$ATOMIC_NUMBER")    #echo $GET_TYPE
    GET_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_MASS
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $MELTING_POINT
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $BOILING_POINT


    echo "The element with atomic number $ATOMIC_NUMBER is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_MASS amu. $GET_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."



  else  #if length is 2 or less
    #echo "You picked the element with the symbol: $1"
    ATOMIC_NUMBER=$($PSQL "Select atomic_number FROM elements WHERE symbol='$1'")
    if [[ -z $ATOMIC_NUMBER ]]
    then
      echo "I could not find that element in the database."
      exit
    fi
    #echo $ATOMIC_NUMBER

    GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_NAME
    GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_SYMBOL
    GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id=properties.type_id WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_TYPE
    GET_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $GET_MASS
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $MELTING_POINT
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    #echo $BOILING_POINT


    echo "The element with atomic number $ATOMIC_NUMBER is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_MASS amu. $GET_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."


  fi
fi





#The element with atomic number 1 is Hydrogen (H). It's a nonmetal, 
#with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius 
#and a boiling point of -252.9 celsius.


#if element is number = atomic_number
#if element is string with length 1 or 2 = symbol
#if element is tring with length >2 = name