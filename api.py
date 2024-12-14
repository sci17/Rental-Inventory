from flask import Flask, make_response, jsonify, request, abort
from flask_mysqldb import MySQL 
import jwt
import datetime
from functools import wraps
from werkzeug.security import generate_password_hash, check_password_hash

SECRET_KEY = "CSE1"

app = Flask(__name__)


app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "Spledelyn1704"
app.config["MYSQL_DB"] = "finalldrill"
app.config["MYSQL_CURSORCLASS"] ="DictCursor"

mysql = MySQL(app)
@app.route("/")
def index():
    return "<h1>Welcome to Item Rental Inventory</h1>"

# CUSTOMERS CRUD
@app.route("/customers", methods=["GET"])
def get_customers():
        cur = mysql.connection.cursor()
        query = """
        select * from customers
        """
        cur.execute(query)
        data = cur.fetchall()
        return make_response(jsonify(data), 200)

@app.route("/customers/<int:id>", methods=["GET"])
def get_customer_id(id):
        cur = mysql.connection.cursor()
        query = """
        SELECT * FROM CUSTOMERS where customer_id = {}
        """ .format(id)
        cur.execute(query)
        data = cur.fetchall()
        return make_response(jsonify(data), 200)
    
        
@app.route("/customers", methods=["POST"])
def add_customer():
    cur = mysql.connection.cursor()
    info = request.get_json()
    first_name = info["first_name"]
    last_name = info["last_name"]
    address = info["address"]
    phone_number = info["phone_number"]
    cell_mobile = info["cell_mobile"]
    email_address = info["email_address"]
    other_details = info["other_details"]

    cur.execute(
        """INSERT INTO customers (first_name, last_name, address, phone_number, cell_mobile, email_address, other_details)
          VALUES (%s, %s, %s, %s, %s, %s, %s)""", (first_name, last_name,address, phone_number, cell_mobile,email_address,other_details)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "customer added successfully", "rows_affected":rows_affected}), 201)

@app.route("/customers/<int:id>", methods=["PUT"])
def update_customer(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    first_name = info["first_name"]
    last_name = info["last_name"]
    address = info["address"]
    phone_number = info["phone_number"]
    cell_mobile = info["cell_mobile"]
    email_address = info["email_address"]
    other_details = info["other_details"]

    cur.execute("""
        UPDATE customers SET first_name = %s, last_name = %s, address = %s, phone_number = %s, cell_mobile = %s, email_address = %s, other_details = %s
                WHERE customer_id = %s""", (first_name, last_name,address, phone_number, cell_mobile, email_address, other_details,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "customer updated successfuly", "rows_affected": rows_affected}), 201)

@app.route("/customers/<int:id>", methods=["DELETE"])
def delete_customers(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM customers where customer_id = %s""",(id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "customers deleted successfully!", "rows_affected": rows_affected}), 200)

  
# accounts
@app.route("/accounts", methods=["GET"])
def get_accounts():
    cur = mysql.connection.cursor()
    query = """
    SELECT 
    a.account_id, 
    a.account_name, 
    pm.payment_method_code, 
    c.customer_id, 
    a.account_details
    FROM 
        accounts AS a
    INNER JOIN 
        payment_methods AS pm
        ON a.payment_method_code = pm.payment_method_code  
    INNER JOIN 
        customers AS c
        ON a.customer_id = c.customer_id;
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/accounts/<int:id>", methods=["GET"])
def get_account_id(id):
    cur = mysql.connection.cursor()
    query = """
    SELECT * from accounts
    WHERE account_id = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/accounts", methods=["POST"])
def add_accounts():
    cur = mysql.connection.cursor()
    info = request.get_json()
    account_name = info["account_name"]
    payment_method_code = info["payment_method_code"]
    customer_id = info["customer_id"]
    account_details = info["account_details"]

    cur.execute(
        """INSERT INTO accounts (account_name, payment_method_code, customer_id, account_details)
          VALUES (%s, %s, %s, %s)""", (account_name, payment_method_code,customer_id, account_details)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "accounts added successfully", "rows_affected":rows_affected}), 201)

@app.route("/accounts/<int:id>", methods=["PUT"])
def update_accounts(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    account_name = info["account_name"]
    payment_method_code = info["payment_method_code"]
    customer_id = info["customer_id"]
    account_details = info["account_details"]

    cur.execute("""
        UPDATE accounts SET account_name = %s, payment_method_code = %s, customer_id = %s, account_details = %s
                WHERE account_id = %s""", (account_name, payment_method_code,customer_id, account_details,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "accounts updated successfuly", "rows_affected": rows_affected}), 201)

@app.route("/accounts/<int:id>", methods=["DELETE"])
def delete_accounts(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM accounts where account_id = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "account deleted successfully!", "rows_affected": rows_affected}), 200)


# financial
@app.route("/financial", methods=["GET"])
def get_financial():
    cur = mysql.connection.cursor()
    query = """
    select * from financial_transactions
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/financial/<int:id>", methods=["GET"])
def get_financial_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from financial_transactions where transaction_id = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/financial", methods=["POST"])
def add_financial():
    cur = mysql.connection.cursor()
    info = request.get_json()
    account_id = info["account_id"]
    item_rental_id = info["item_rental_id"]
    purchase_id = info["purchase_id"]
    previous_transaction_id = info["previous_transaction_id"]
    transaction_date = info["transaction_date"]
    transaction_type_code = info["transaction_type_code"]
    transaction_amount = info["transaction_amount"]
    comment = info["comment"]

    cur.execute(
        """INSERT INTO financial_transactions (account_id, item_rental_id, purchase_id, previous_transaction_id, transaction_date, transaction_type_code, transaction_amount, comment)
          VALUES (%s, %s, %s, %s,%s, %s, %s, %s)""", (account_id, item_rental_id,purchase_id, previous_transaction_id, transaction_date, transaction_type_code, transaction_amount, comment)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "financial transaction added successfully", "rows_affected":rows_affected}), 201)

@app.route("/financial/<int:id>", methods=["PUT"])
def update_financial(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    account_id = info["account_id"]
    item_rental_id = info["item_rental_id"]
    purchase_id = info["purchase_id"]
    previous_transaction_id = info["previous_transaction_id"]
    transaction_date = info["transaction_date"]
    transaction_type_code = info["transaction_type_code"]
    transaction_amount = info["transaction_amount"]
    comment = info["comment"]

    cur.execute("""
        UPDATE financial_transactions SET account_id = %s, item_rental_id = %s, purchase_id = %s, previous_transaction_id = %s, transaction_date = %s, transaction_type_code = %s, transaction_amount = %s, comment = %s
                WHERE transaction_id = %s""", (account_id, item_rental_id,purchase_id, previous_transaction_id, transaction_date, transaction_type_code, transaction_amount,comment,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "financial transaction updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/financial/<int:id>", methods=["DELETE"])
def delete_financial(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM financial_transaction where transaction_id = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "financial transaction deleted successfully!", "rows_affected": rows_affected}), 200)



# purchases
@app.route("/purchases", methods=["GET"])
def get_purchases():
    cur = mysql.connection.cursor()
    query = """
    SELECT 
    cip.purchase_status_code,
    cip.purchase_date,
    cip.purchase_quantity,
    cip.amount_due,
    c.customer_id,
    ii.item_id
    FROM 
        customer_item_purchases AS cip
    INNER JOIN 
        customers AS c
        ON cip.customer_id = c.customer_id  
    INNER JOIN 
        inventory_items AS ii
        ON cip.item_id = ii.item_id;
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/purchases/<int:id>", methods=["GET"])
def get_purchases_id(id):
    cur = mysql.connection.cursor()
    query = """
    SELECT 
    cip.purchase_status_code,
    cip.purchase_date,
    cip.purchase_quantity,
    cip.amount_due,
    c.customer_id,
    ii.item_id
    FROM 
        customer_item_purchases AS cip
    INNER JOIN 
        customers AS c
        ON cip.customer_id = c.customer_id  
    INNER JOIN 
        inventory_items AS ii
        ON cip.item_id = ii.item_id
    WHERE cip.purchase_status_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/purchases", methods=["POST"])
def add_purchases():
    cur = mysql.connection.cursor()
    info = request.get_json()
    purchase_status_code = info["purchase_status_code"]
    customer_id = info["customer_id"]
    item_id = info["item_id"]
    purchase_date = info["purchase_date"]
    purchase_quantity = info["purchase_quantity"]
    amount_due = info["amount_due"]

    cur.execute(
        """INSERT INTO customer_item_purchases (purchase_status_code, customer_id, item_id, purchase_date, purchase_quantity, amount_due)
          VALUES (%s, %s, %s, %s,%s, %s)""", (purchase_status_code, customer_id,item_id, purchase_date, purchase_quantity, amount_due)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "item purchases transaction added successfully", "rows_affected":rows_affected}), 201)

@app.route("/purchases/<int:id>", methods=["PUT"])
def update_purchase(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    purchase_status_code = info["purchase_status_code"]
    customer_id = info["customer_id"]
    item_id = info["item_id"]
    purchase_date = info["purchase_date"]
    purchase_quantity = info["purchase_quantity"]
    amount_due = info["amount_due"]

    cur.execute("""
        UPDATE customer_item_purchases SET purchase_status_code = %s, customer_id = %s, item_id = %s, purchase_date = %s, purchase_quantity = %s, amount_due = %s
                WHERE purchase_id = %s""", (purchase_status_code, customer_id,item_id, purchase_date, purchase_quantity, amount_due,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "customer purchases updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/purchases/<int:id>", methods=["DELETE"])
def delete_purchase(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM customer_item_purchases where purchase_id = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "purchased item deleted successfully!", "rows_affected": rows_affected}), 200)


# rentals
@app.route("/rentals", methods=["GET"])
def get_rentals():
    cur = mysql.connection.cursor()
    query = """
    select * from customer_item_rentals
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/rentals/<int:id>", methods=["GET"])
def get_rentals_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from customer_item_rentals where item_rental_id = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/rentals", methods=["POST"])
def add_rentals():
    cur = mysql.connection.cursor()
    info = request.get_json()
    customer_id = info["customer_id"]
    item_id = info["item_id"]
    rental_date_out = info["rental_date_out"]
    rental_date_returned = info["rental_date_returned"]
    amount_due = info["amount_due"]
    other_details = info["other_details"]

    cur.execute(
        """INSERT INTO customer_item_rentals (customer_id, item_id, rental_date_out, rental_date_returned, amount_due, other_details)
          VALUES (%s, %s, %s, %s,%s, %s)""", (customer_id,item_id, rental_date_out, rental_date_returned, amount_due, other_details)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "rental transaction added successfully", "rows_affected":rows_affected}), 201)

@app.route("/rentals/<int:id>", methods=["PUT"])
def update_rentals(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    customer_id = info["customer_id"]
    item_id = info["item_id"]
    rental_date_out = info["rental_date_out"]
    rental_date_returned = info["rental_date_returned"]
    amount_due = info["amount_due"]
    other_details = info["other_details"]

    cur.execute("""
        UPDATE customer_item_rentals SET customer_id = %s, item_id = %s, rental_date_out = %s, rental_date_returned = %s, amount_due = %s, other_details = %s
                WHERE item_rental_id = %s""", (customer_id, item_id,rental_date_out, rental_date_returned, amount_due, other_details,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "customer rental updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/rentals/<int:id>", methods=["DELETE"])
def delete_rentals(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM customer_item_rentals where item_rental_id = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "rental deleted successfully!", "rows_affected": rows_affected}), 200)



# item type
@app.route("/item_type", methods=["GET"])
def get_item_type():
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_item_types
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/item_type/<int:id>", methods=["GET"])
def get_item_type_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_item_types where item_type_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/item_type", methods=["POST"])
def add_item_type():
    cur = mysql.connection.cursor()
    info = request.get_json()
    item_type_code = info["item_type_code"]
    description = info["description"]

    cur.execute(
        """INSERT INTO inventory_item_types (item_type_code,description)
          VALUES (%s, %s)""", (item_type_code,description)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "item type transaction added successfully", "rows_affected":rows_affected}), 201)

@app.route("/item_type/<int:id>", methods=["PUT"])
def update_item_type(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    item_type_code = info["item_type_code"]
    description = info["description"]

    cur.execute("""
        UPDATE inventory_item_types SET item_type_code = %s, description = %s
                WHERE item_type_code = %s""", (item_type_code, description,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "item type updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/item_type/<int:id>", methods=["DELETE"])
def delete_item_type(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM inventory_item_types where item_type_code = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "item type deleted successfully!", "rows_affected": rows_affected}), 200)


# items
@app.route("/items", methods=["GET"])
def get_items():
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_items
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/items/<int:id>", methods=["GET"])
def get_items_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_items where item_id = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/items", methods=["POST"])
def add_items():
    cur = mysql.connection.cursor()
    info = request.get_json()
    item_id = info["item_id"]
    item_type_code = info["item_type_code"]
    description = info["description"]
    number_in_stocks = info["number_in_stocks"]
    rental_sale_both = info["rental_sale_both"]
    rental_daily_rate = info["rental_daily_rate"]
    sale_price = info["sale_price"]

    cur.execute(
        """INSERT INTO inventory_items (item_id,item_type_code,description,number_in_stocks, rental_sale_both, rental_daily_rate, sale_price )
          VALUES (%s, %s,%s, %s,%s, %s,%s)""", (item_id,item_type_code,description, number_in_stocks, rental_sale_both,rental_daily_rate,sale_price)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "items added successfully", "rows_affected":rows_affected}), 201)

@app.route("/items/<int:id>", methods=["PUT"])
def update_items(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    item_id = info["item_id"]
    item_type_code = info["item_type_code"]
    description = info["description"]
    number_in_stocks = info["number_in_stocks"]
    rental_sale_both = info["rental_sale_both"]
    rental_daily_rate = info["rental_daily_rate"]
    sale_price = info["sale_price"]

    cur.execute("""
        UPDATE inventory_items SET item_id = %s, item_type_code = %s, description = %s, number_in_stocks = %s, rental_sale_both = %s, rental_daily_rate = %s, sale_price = %s
                WHERE item_id = %s""", (item_id,item_type_code, description,number_in_stocks, rental_sale_both,rental_daily_rate, sale_price,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "items updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/items/<int:id>", methods=["DELETE"])
def delete_items(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM inventory_items where item_id = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "item(s) deleted successfully!", "rows_affected": rows_affected}), 200)


# purchase_status_code
@app.route("/status_code", methods=["GET"])
def get_status_code():
    cur = mysql.connection.cursor()
    query = """
    select * from purchase_status_codes
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/status_code/<int:id>", methods=["GET"])
def get_status_code_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from purchase_status_codes where purchase_status_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)


@app.route("/status_code", methods=["POST"])
def add_status_code():
    cur = mysql.connection.cursor()
    info = request.get_json()
    purchase_status_code = info["purchase_status_code"]
    description = info["description"]

    cur.execute(
        """INSERT INTO purchase_status_codes (purchase_status_code,description)
          VALUES (%s, %s)""", (purchase_status_code,description)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "status code added successfully", "rows_affected":rows_affected}), 201)

@app.route("/status_code/<int:id>", methods=["PUT"])
def update_status_code(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    purchase_status_code = info["purchase_status_code"]
    description = info["description"]

    cur.execute("""
        UPDATE purchase_status_codes SET purchase_status_code = %s, description = %s
                WHERE purchase_status_code = %s""", (purchase_status_code, description,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "status code updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/status_code/<int:id>", methods=["DELETE"])
def delete_status_code(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM purchase_status_codes where purchase_status_code = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "status code deleted successfully!", "rows_affected": rows_affected}), 200)



#  transaction types
@app.route("/transaction", methods=["GET"])
def get_transaction():
    cur = mysql.connection.cursor()
    query = """
    select * from transaction_types
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/transaction/<int:id>", methods=["GET"])
def get_transaction_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from transaction_types where transaction_type_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/transaction", methods=["POST"])
def add_transaction():
    cur = mysql.connection.cursor()
    info = request.get_json()
    transaction_type_code = info["transaction_type_code"]
    description = info["description"]

    cur.execute(
        """INSERT INTO transaction_types (transaction_type_code,description)
          VALUES (%s, %s)""", (transaction_type_code,description)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "transaction type added successfully", "rows_affected":rows_affected}), 201)

@app.route("/transaction/<int:id>", methods=["PUT"])
def update_transaction(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    transaction_type_code = info["transaction_type_code"]
    description = info["description"]

    cur.execute("""
        UPDATE transaction_types SET transaction_type_code = %s, description = %s
                WHERE transaction_type_code = %s""", (transaction_type_code, description,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "transaction type updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/transaction/<int:id>", methods=["DELETE"])
def delete_transaction(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM transaction_types where transaction_type_code = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "transaction type deleted successfully!", "rows_affected": rows_affected}), 200)



# payment methods
@app.route("/payment", methods=["GET"])
def get_payment():
    cur = mysql.connection.cursor()
    query = """
    select * from payment_methods
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/payment/<int:id>", methods=["GET"])
def get_payment_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from payment_methods where payment_method_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/payment", methods=["POST"])
def add_payments():
    cur = mysql.connection.cursor()
    info = request.get_json()
    payment_method_code = info["payment_method_code"]
    description = info["description"]

    cur.execute(
        """INSERT INTO payment_methods (payment_method_code,description)
          VALUES (%s, %s)""", (payment_method_code,description)
    )
    mysql.connection.commit()
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    return make_response(jsonify({"message": "transaction type added successfully", "rows_affected":rows_affected}), 201)

@app.route("/payment/<int:id>", methods=["PUT"])
def update_payments(id):
    cur = mysql.connection.cursor()
    info = request.get_json()
    payment_method_code = info["payment_method_code"]
    description = info["description"]

    cur.execute("""
        UPDATE payment_methods SET payment_method_code = %s, description = %s
                WHERE payment_method_code = %s""", (payment_method_code, description,id)
    )
    print("row(s) affected: {}".format(cur.rowcount))
    rows_affected = cur.rowcount
    mysql.connection.commit()
    return make_response(jsonify({"message": "payment method updated successfuly", "rows_affected": rows_affected}), 201)


@app.route("/paymnet/<int:id>", methods=["DELETE"])
def delete_payment(id):
    cur = mysql.connection.cursor()

    cur.execute("""DELETE FROM payment_method where payment_method_code = %s""",( id,))

    mysql.connection.commit()
    rows_affected = cur.rowcount
    cur.close()
    return make_response(jsonify({"message": "payment method deleted successfully!", "rows_affected": rows_affected}), 200)




if __name__== "__main__":
    app.run(debug=True)