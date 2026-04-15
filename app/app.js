const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.json({ message: "DevOps Lab Running 🚀" });
});

app.listen(3000);
