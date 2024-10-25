#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#When file runs: Please provide an element as an argument.
MAIN_MENU() {
  if [[ -z $1 ]]
    then
    echo "Please provide an element as an argument."
  else
  CHECK_DATABASE "$1"
  fi
}

CHECK_DATABASE() {
  CHECK_DATABASE_FOR_ARGUMENT=null
  CHECK_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  echo "atomic number: $CHECK_ATOMIC_NUMBER"
  #if argument doesn't exist in database, print error message: I could not find that element in the database.
  CHECK_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  echo "symbol: $CHECK_SYMBOL"
}

MAIN_MENU "$1"