from flask import Flask, make_response, jsonify
from flask_mysqldb import MySQL 

app = Flask(__name__)


app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = "Spledelyn1704"
app.config["MYSQL_DB"] = "rental"

app.config["MYSQL_CURSORCLASS"] ="DictCursor"

mysql = MySQL(app)
@app.route("/")
def hello_world():
    return "<p>Hello, World</p>"

@app.route("/customers", methods=["GET"])
def get_customers():
    cur = mysql.connection.cursor()
    query = """
    select * from customers
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)
  

@app.route("/accounts", methods=["GET"])
def get_accounts():
    cur = mysql.connection.cursor()
    query = """
    select * from accounts
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)


@app.route("/financial", methods=["GET"])
def get_financial():
    cur = mysql.connection.cursor()
    query = """
    select * from financial_transactions
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/purchases", methods=["GET"])
def get_purchases():
    cur = mysql.connection.cursor()
    query = """
    select * from customer_item_purchases
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/rentals", methods=["GET"])
def get_rentals():
    cur = mysql.connection.cursor()
    query = """
    select * from customer_item_rentals
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/item_type", methods=["GET"])
def get_item_type():
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_item_types
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)
@app.route("/items", methods=["GET"])
def get_items():
    cur = mysql.connection.cursor()
    query = """
    select * from inventory_items
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/status_code", methods=["GET"])
def get_status_code():
    cur = mysql.connection.cursor()
    query = """
    select * from purchase_status_codes
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/transaction", methods=["GET"])
def get_transaction():
    cur = mysql.connection.cursor()
    query = """
    select * from transaction_types
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)

@app.route("/payment", methods=["GET"])
def get_payment():
    cur = mysql.connection.cursor()
    query = """
    select * from payment_methods
    """
    cur.execute(query)
    data = cur.fetchall()
    return make_response(jsonify(data), 200)



if __name__== "__main__":
    app.run(debug=True)