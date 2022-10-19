var mongoose = require('mongoose')
var Schema = mongoose.Schema

var item = new Schema({
    title: String,
    expDate: String,
    remindDate: String
})

const Data = mongoose.model("data", item)

module.exports = Data