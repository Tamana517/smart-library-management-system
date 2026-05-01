from flask import Flask, render_template, request, redirect
import cx_Oracle

app = Flask(__name__)

conn = cx_Oracle.connect("library_user/lib123@localhost/XEPDB1")
cursor = conn.cursor()

@app.route('/')
def index():
    return render_template('index.html')

# ---------------- BOOKS ----------------
@app.route('/books')
def books():
    cursor.execute("SELECT * FROM BOOKS")
    data = cursor.fetchall()
    return render_template('books.html', books=data)

@app.route('/add_book', methods=['POST'])
def add_book():
    title = request.form['title']
    author = request.form['author']

    cursor.execute(
        "INSERT INTO BOOKS VALUES (BOOK_SEQ.NEXTVAL, :1, :2, 1, 1)",
        [title, author]
    )
    conn.commit()
    return redirect('/books')

# ---------------- MEMBERS ----------------
@app.route('/members')
def members():
    cursor.execute("SELECT * FROM MEMBERS")
    data = cursor.fetchall()
    return render_template('members.html', members=data)

@app.route('/add_member', methods=['POST'])
def add_member():
    name = request.form['name']
    email = request.form['email']
    phone = request.form['phone']

    cursor.execute(
        "INSERT INTO MEMBERS VALUES (MEMBER_SEQ.NEXTVAL, :1, :2, :3, 1)",
        [name, email, phone]
    )
    conn.commit()
    return redirect('/members')

# ---------------- ISSUE ----------------
@app.route('/issue_page')
def issue_page():
    return render_template('issue.html')

@app.route('/issue', methods=['POST'])
def issue():
    member_id = request.form['member_id']
    book_id = request.form['book_id']

    cursor.callproc('issue_book', [member_id, book_id])
    return redirect('/')

# ---------------- RETURN ----------------
@app.route('/return_page')
def return_page():
    return render_template('return.html')

@app.route('/return', methods=['POST'])
def return_book():
    issue_id = request.form['issue_id']
    cursor.callproc('return_book', [issue_id])
    return redirect('/')

# ---------------- AUDIT LOG ----------------
@app.route('/audit')
def audit():
    cursor.execute("SELECT * FROM AUDIT_LOG ORDER BY action_date DESC")
    data = cursor.fetchall()
    return render_template('audit_log.html', logs=data)

if __name__ == '__main__':
    app.run(debug=True)