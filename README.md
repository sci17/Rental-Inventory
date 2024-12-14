# Item Rental Inventory
### Rental Inventory ia a Flask-based API for managing rental inventory. It tracks customer, accounts, items, purchase, and financial transactions. 

## Features 
* **ACCOUNTS** - for tracking the account name and details
* **CUSTOMERS** - store the details of customers
* **FINANCIAL TRANSACTION** - tracks down the history of financial transaction
* **TRANSACTION TYPE** - give details for the specific transaction
* **PAYMENT METHOD** - holds detail regarding the payment of the customers
* **ITEM PURCHASE** - store the details about the items that purchased by the customers
* **ITEM TYPE** - have a detailed info about the type of the items
* **ITEM RENTALS** - store information about customer rental transactions
* **ITEMS** - give specific items for the customers
* **STATUS CODE** - used for tracking the status of the items 

# Installation Process
## 1. Create a virtual environment
 Create a virtual environment in your project directory
```bash
python -m venv .venv
```
## 2. After creating the virtual environment, you need to activate it.
* On Windows
```bash
myenv\Scripts\activate
```
* On macOS/Linux:
```bash
source myenv/bin/activate
```
## 3. Install Packages
```bash
pip install flask
```
```bash
pip install mysql-connector-python
```
```bash
pip install -r requirements.txt
```
* If requirements.txt is does not exist, create it first.
```bash
pip freeze > requirements.txt
```
# Configuration
## 1. Setup your Virtual Environment
Environment Variables needed:
```.env
HOSTNAME = "localhost"
USERNAME = "your_username"
PASSWORD = "your_password"
DATABASE = "backup"
```
Ensure that you will replace your actual database credentials.
## 2. Run the application
Run the application using this command:
```bash
python api.py
```
After running the command, the server will give an access at 'http://127.0.0.1:5000'
# API ENDPOINTS
Here are the endpoints for this project:
* **GET/customers**: Retrieve all customers.
* **GET/customers/<customer_id>**: Get details of specific customers.
* **POST/customers**: Add a new customer to the database.
* **PUT/customers/<customer_id>**: Update the details of specific customer.
* **DELETE/customers/<customer_id>**: Delete the records of specific customer.

  
* **GET/accounts**: Retrieve all accounts.
* **GET/accounts/<account_id>**: Get details of specific account.
* **POST/accounts**: Add a new account to the database.
* **PUT/accounts/<account_id>**: Update the details of specific customer.
* **DELETE/accounts/<account_id>**: Delete the records of specific customer.


* **GET/purchases**: Retrieve all item purchased.
* **GET/purchases/<purchase_id>**: Get details of specific purchased item.
* **POST/purchases**: Add a new purchased item to the database.
* **PUT/purchases/<purchase_id>**: Update the details of specific purchased item.
* **DELETE/purchases/<purchase_id>**: Delete the records of specific purchased item.


* **GET/rentals**: Retrieve all rental items.
* **GET/rentals/<rental_id>**: Get details of specific rental item.
* **POST/rentals**: Add a new rental item to the database.
* **PUT/rentals/<rental_id>**: Update the details of specific rental item.
* **DELETE/rentals/<rental_id>**: Delete the records of specific rental item.


* **GET/financial**: Retrieve all financial transactions.
* **GET/financial/<financial_id>**: Get details of specific financial transaction.
* **POST/financial**: Add a new financial transaction to the database.
* **PUT/financial/<financial_id>**: Update the details of specific financial transaction.
* **DELETE/financial/<financial_id>**: Delete the records of specific financial transaction.


* **GET/item_type**: Retrieve all type of item.
* **GET/item_type/<item_type_code>**: Get details of specific type of item.
* **POST/item_type**: Add a new type of item to the database.
* **PUT/item_type/<item_type_code>**: Update the details of specific type of item.
* **DELETE/item_type/<item_type_code>**: Delete the records of specific type of item.


* **GET/rentals**: Retrieve all rental items.
* **GET/rentals/<rental_id>**: Get details of specific rental item.
* **POST/rentals**: Add a new rental item to the database.
* **PUT/rentals/<rental_id>**: Update the details of specific rental item.
* **DELETE/rentals/<rental_id>**: Delete the records of specific customer.

  
* **GET/items**: Retrieve all items.
* **GET/items/<item_id>**: Get details of specific item.
* **POST/items**: Add a new item to the database.
* **PUT/items/<item_id>**: Update the details of specific item.
* **DELETE/items/<item_id>**: Delete the records of specific item.


* **GET/payment**: Retrieve all payment methods.
* **GET/payment/<payment_id>**: Get details of specific payment methods.
* **POST/payment**: Add a new payment methods to the database.
* **PUT/payment/<payment_id>**: Update the details of specific payment methods.
* **DELETE/payment/<payment_id>**: Delete the records of specific payment methods.

  
* **GET/status_code**: Retrieve all purchase status.
* **GET/status_code/<status_code>**: Get details of specific purchase status .
* **POST/status_code**: Add a new purchase status to the database.
* **PUT/status_code/<status_code>**: Update the details of specific purchase status.
* **DELETE/status_code/<status_code>**: Delete the records of specific purchase status.


* **GET/transaction**: Retrieve all transaction type.
* **GET/transaction/<transaction_id>**: Get details of specific transaction type.
* **POST/transaction**: Add a new transaction type to the database.
* **PUT/transaction/<transaction_id>**: Update the details of specific transaction type.
* **DELETE/transaction/<transaction_id>**: Delete the records of specific transaction_type.

## Git Commit Guidelines
Here are the steps for commiting your changes:
1. Fork the repository.
2. Clone your forked repository into your local ('git clone URL').
3. Make a changes and add ('git add . ').
4. Commit your changes ('git commit -m "your message" ').
5. Push your commit into your repository ('git push').
6. Create a pull request. 



