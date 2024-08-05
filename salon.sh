#!/bin/bash
PSQL="psql -tAX --username=freecodecamp --dbname=salon -c"

echo -e "\n ~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # Get all the services available
  SERVICES_RESULT=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  # Prnt a formatted Service Menu
  echo "$SERVICES_RESULT" | while IFS="|" read SERVICE_ID NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  #echo -e "\nWhich service do you want to have an appointment?"
  read SERVICE_ID_SELECTED

  # Check if the selected service is available
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # If not send back to main menu until correct
  if [[ -z $SERVICE_NAME ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  fi

  echo -e "\nNow that we know what you want, Let us know you.\nWhat is your phone number (This is used for identification)"
  read CUSTOMER_PHONE

  # Check is the user already exits in our database
  CUSTOMER_NAME=$($PSQL "SELECT name from customers WHERE phone = '$CUSTOMER_PHONE'")

  # if not in the database
  if [[ -z $CUSTOMER_NAME ]]
  then
    # ask for name
    echo -e "\nI think this is your first visit to us. We won't disappoint you.\nLet us know each other i am a fking terminal!!!\nWhats your name?"
    read CUSTOMER_NAME

    # Insert the phone & name to customers table
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

    if [[ $INSERT_CUSTOMER_RESULT = 'INSERT 0 1' ]]
    then
      echo -e "\nNow we are going to remember you. The next time you come we will fill your details for you."
    fi
  fi

  echo -e "\nWhich at which time do you want your $SERVICE_NAME? I will book an appointment for you."
  read SERVICE_TIME

  # get customer_id from customers table with user phone no.
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  
  # Insert customer_id, service_id & time in appoinments table
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  if [[ $INSERT_APPOINTMENT_RESULT = 'INSERT 0 1' ]]
  then
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

MAIN_MENU