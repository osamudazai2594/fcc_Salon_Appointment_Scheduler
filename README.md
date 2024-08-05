# Salon Appointment Scheduler

## Description
This project is a bash script that simulates a salon appointment scheduling system. It interacts with a PostgreSQL database to manage customers, services, and appointments.

## Features
- Displays a list of available services
- Allows users to book appointments by selecting a service, providing their phone number, and choosing a time
- Manages customer information, creating new customer records as needed
- Stores appointment details in a database

## Technologies Used
- Bash scripting
- PostgreSQL database
- Git (for version control)

## Setup and Installation
1. Ensure you have PostgreSQL installed on your system.
2. Clone this repository:
   ```
   git clone https://github.com/your-username/salon-appointment-scheduler.git
   ```
3. Navigate to the project directory:
   ```
   cd salon-appointment-scheduler
   ```
4. Set up the PostgreSQL database:
   ```
   psql -U postgres < salon.sql
   ```
5. Make the script executable:
   ```
   chmod +x salon.sh
   ```

## Usage
Run the script using the following command:
```
./salon.sh
```
Follow the prompts to book an appointment:
1. Select a service from the displayed list
2. Enter your phone number
3. If you're a new customer, enter your name
4. Choose an appointment time

## Database Structure
The project uses three main tables:
- `customers`: Stores customer information (id, name, phone)
- `services`: Stores available services (id, name)
- `appointments`: Stores appointment details (id, customer_id, service_id, time)

## Contributing
This project was completed as part of a FreeCodeCamp challenge. While it's not open for contributions, feel free to fork the repository and modify it for your own learning purposes.

## Acknowledgements
- FreeCodeCamp for providing the project requirements and learning resources
- The PostgreSQL community for their excellent documentation
