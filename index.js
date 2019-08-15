const path = require("path");
const express = require("express");
//use bodyParser middleware
const bodyParser = require("body-parser");
//use mysql database
const mysql = require("mysql");
const util = require("util");
const app = express();

//Create Connection
const conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "perpustakaan"
});

//connect to database
conn.connect(err => {
  if (err) throw err;
  console.log("Mysql Connected!");
});

const query = util.promisify(conn.query).bind(conn);

//set views file
app.set("views", path.join(__dirname, "views"));
//set view engine
app.set("view engine", "ejs");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
//set folder public as static folder for static file
app.use("/assets", express.static(__dirname + "/public"));

//route for homepage
app.get("/", async (req, res) => {
  try {
    const book = await query("SELECT id,title FROM book");
    const student = await query("SELECT id,name FROM student");
    res.render("index", {
      book,
      student
    });
  } catch (e) {
    console.error(e);
  }
});

app.get("/ready", async (req, res) => {
  try {
    const borrow = await query(
      "SELECT book.title AS title, student.name AS name FROM borrowed INNER JOIN book ON book.id = borrowed.id_book INNER JOIN student ON student.id = borrowed.id_student"
    );

    const most = await query(
      "SELECT book.title AS title, book.borrowed AS borrowed FROM book ORDER BY book.borrowed DESC LIMIT 10"
    );

    return res.status(200).json([borrow, most]);
  } catch (e) {
    return res.status(500).end();
  }
});

//route for insert data
app.post("/", async (req, res) => {
  try {
    const borrowed = await query(
      `SELECT count(id_student) AS borrowed FROM borrowed WHERE id_student = ${
        req.body.student
      }`
    );

    if (borrowed[0].borrowed == 3) {
      return res.status(400).json({ error: "full" });
    }

    const data = {
      id_book: req.body.book,
      id_student: req.body.student
    };

    await query("INSERT INTO borrowed SET ?", data);
    await query(
      `UPDATE book SET borrowed = borrowed + 1 WHERE id = ${data.id_book}`
    );

    return res.status(200).json({ success: "true" });
  } catch (e) {
    return res.status(500);
  }
});

//route for delete data
app.delete("/", async (req, res) => {
  try {
    const borrowed = await query(
      `SELECT count(id_student) AS borrowed FROM borrowed WHERE id_student = ${
        req.query.student
      }`
    );

    if (borrowed[0].borrowed == 0) {
      return res.status(400).json({ error: "empty" });
    }

    const deleteIt = await query(
      `DELETE FROM borrowed WHERE id_book = ${
        req.query.book
      } AND id_student = ${req.query.student}`
    );

    if (deleteIt.affectedRows == 0) {
      return res.status(400).json({ error: "no" });
    }

    return res.status(200).json({ success: "true" });
  } catch (e) {
    return res.status(500);
  }
});

//server listening
app.listen(8000, () => {
  console.log("Server is running at port 8000");
});
