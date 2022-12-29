const {Client} = require('pg');
const configs = require('../configs/db')
const User = require ('./Users')

const client = new Client(configs);



User._client = client;
User._tableName = 'users';

module.exports = {
    client, User
}