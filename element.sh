#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#When file runs: Please provide an element as an argument.
MAIN_MENU() {
  if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
  return
  else
  CHECK_DATABASE
  fi
}

CHECK_DATABASE() {
  CHECK_DATABASE_FOR_ARGUMENT=null
  CHECK_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  echo $CHECK_ATOMIC_NUMBER
  #if argument doesn't exist in database, print error message: I could not find that element in the database.
}

MAIN_MENU