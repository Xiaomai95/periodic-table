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
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
  GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
  echo $GET_ATOMIC_NUMBER
  echo $GET_SYMBOL
  echo $GET_ELEMENT_NAME

  #get rest of information
  #Use the info you got to get the rest of the info you need
  if [[ $GET_ATOMIC_NUMBER ]]
    then  
      GET_SYMBOL=$($PSQL "SELECT symbol FROM elements INNER JOIN properties ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $GET_ATOMIC_NUMBER")
      GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements INNER JOIN properties ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = $GET_ATOMIC_NUMBER")
      GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON properties.type_id = types.type_id WHERE properties.atomic_number = $GET_ATOMIC_NUMBER")
      GET_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $GET_ATOMIC_NUMBER")
      GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $GET_ATOMIC_NUMBER")
      GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $GET_ATOMIC_NUMBER")
    elif [[ $GET_SYMBOL ]]
      then 
      GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$GET_SYMBOL'")
      GET_ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$GET_SYMBOL'")
      GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id = properties.type_id INNER JOIN elements ON elements.atomic_number = properties.atomic_number WHERE elements.symbol = '$GET_SYMBOL'")
      GET_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol = '$GET_SYMBOL'")
      GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol = '$GET_SYMBOL'")
      GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol = '$GET_SYMBOL'")

    elif [[ $GET_ELEMENT_NAME ]]
      then 
      GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$GET_ELEMENT_NAME'")
      GET_SYMBOL=$($PSQL "SELECT symbol FROM elements INNER JOIN properties ON properties.atomic_number = elements.atomic_number WHERE elements.name = $GET_ELEMENT_NAME")
      GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties ON types.type_id = properties.type_id INNER JOIN elements ON elements.atomic_number = properties.atomic_number WHERE name = '$GET_ELEMENT_NAME'")
      GET_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$GET_ELEMENT_NAME'")
      GET_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$GET_ELEMENT_NAME'")
      GET_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE elements.name = '$GET_ELEMENT_NAME'")
    else
    echo "I could not find that element in the database."
  fi
  
  #get type, mass, melting point and boiling point
  if [[ $GET_ATOMIC_NUMBER && $GET_SYMBOL && $GET_ELEMENT_NAME && $GET_TYPE && $GET_MASS && $GET_BOILING_POINT && $GET_MELTING_POINT ]]
    then
    echo -e "The element with atomic number $(echo $GET_ATOMIC_NUMBER | sed 's/^ +| $+//g') is $(echo $GET_ELEMENT_NAME | sed 's/^ +| $+//g') ($(echo $GET_SYMBOL | sed 's/^ +| $+//g')). It's a $(echo $GET_TYPE | sed 's/^ +| $+//g'), with a mass of $(echo $GET_MASS | sed 's/^ +| $+//g') amu. $(echo $GET_ELEMENT_NAME | sed 's/^ +| $+//g') has a melting point of $(echo $GET_MELTING_POINT | sed 's/^ +| $+//g') celsius and a boiling point of $(echo $GET_BOILING_POINT | sed 's/^ +| $+//g') celsius."
  fi
}

MAIN_MENU "$1"