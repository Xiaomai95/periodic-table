#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

#When file runs: Please provide an element as an argument.
if [[ -z $1 ]]
  then
  echo "Please provide an element as an argument."
fi


#if argument doesn't exist in database, print error message: I could not find that element in the database.

