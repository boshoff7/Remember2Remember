const express = require('express')
const mongoose = require('mongoose')
var app = express()
var Data = require('./itemSchema')

mongoose.connect("mongodb://localhost/myDB")

mongoose.connection.once("open", () => {
    console.log("Connected to DB!")
}).on("error", (error) => {
    console.log("Failed to connect" + error)
})

// Create an item
// POST request
app.post("/create", (req, res) => {

    var item = new Data({

        title: req.get("title"),
        expDate: req.get("expDate"),
        remindDate: req.get("remindDate"),

    })

    item.save().then(() => {

        if (item.isNew == false) {
            console.log("Saved data!")
            res.send("Saved data!")
        } else {
            console.log("Failed to save data")
        }
    })
})

// http://192.168.0.103:8081/create
var server = app.listen(8081, "192.168.0.103", () => {
    console.log("Server is running")
})

// Delete an item
// POST request

// Update an item
// POST request

// Fetch all items
// GET request