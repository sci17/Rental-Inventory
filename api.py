from flask import Flask, make_response, jsonify, request
from flask_mysqldb import MySQL 

app = Flask(__name__)


app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "Spledelyn1704"
app.config["MYSQL_DB"] = "finalldrill"

app.config["MYSQL_CURSORCLASS"] ="DictCursor"

mysql = MySQL(app)
@app.route("/")
def hello_world():
    return "<p>Hello, World</p>"

# customers 
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
        ON a.customer_id = c.customer_id  
    WHERE a.account_id = {}
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
    select * from inventory_item_typrs where item_type_code = {}
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
    select * from purchase_status_code where purchase_status_code = {}
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
    select * from financial_transactions where transaction_id = {}
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

@app.route("/payments/<int:id>", methods=["GET"])
def get_payment_id(id):
    cur = mysql.connection.cursor()
    query = """
    select * from payment_methods where payment_method_code = {}
    """.format(id)
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/payments", methods=["POST"])
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



if __name__== "__main__":
    app.run(debug=True)