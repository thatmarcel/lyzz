const express = require("express");
const app = express();

app.use("/log", (req, res) => {
    console.log(req.query.string);
    res.status(200).end();
});

app.listen(7070);
