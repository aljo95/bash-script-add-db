#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  SERVICE_AND_NAME=$($PSQL "SELECT service_id, name FROM services")

  echo "Choose a service:"
  echo "$SERVICE_AND_NAME" | while read SERVICE_ID SERVICE_NAME
  do
    DISPLAY_SERVICES=$(echo "$SERVICE_ID) $SERVICE_NAME" | sed 's/ | / /')
    echo $DISPLAY_SERVICES
  done
  read SERVICE_ID_SELECTED
  SERVICE_SELECTED=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_SELECTED ]]
  then
    MAIN_MENU "Pick an existing service."
  else
    echo "Enter phone number:"
    read CUSTOMER_PHONE
    CUSTOMER_PHONE_SELECTED=$($PSQL "SELECT phone FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_PHONE_SELECTED ]]
    then
      echo "Enter name:"
      read CUSTOMER_NAME
      CUSTOMER_PHONE_AND_NAME_INSERT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    else
      CUSTOMER_NAME_SELECTED=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    fi
    CUSTOMER_ID_SELECTED=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    echo "Enter time:"
    read SERVICE_TIME
    #SERVICE_TIME_SELECTED=$($PSQL "INSERT INTO appointments(time) VALUES('$SERVICE_TIME')")
    #SERVICE_TIME_SELECTED=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) 
    #                                   VALUES(, ,'$SERVICE_TIME')")
    SERVICE_TIME_SELECTED=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID_SELECTED, $SERVICE_SELECTED, '$SERVICE_TIME')")
  fi
  
  echo $SERVICE_SELECTED
  SERVICE_NAME_SELECTEDD=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_SELECTED'")
  #I have put you down for a <service> at <time>, <name>.
  #echo $SERIVCE_NAME_SELECTEDD

}
MAIN_MENU

echo $CUSTOMER_NAME
echo $SERVICE_NAME_SELECTEDD
echo "I have put you down for a$SERVICE_NAME_SELECTEDD at $SERVICE_TIME, $CUSTOMER_NAME."