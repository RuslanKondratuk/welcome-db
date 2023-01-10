
const {mapUsers} = require('./mapUsers');
const configs = require('./configs/db');
const {getUsers} = require('./api/index');
const {client, User, Phone, Order} = require('./models/index');
const {generatePhones} = require ('./utils/generate');



async function start() {
    await client.connect();

    const usersArray = await getUsers();

    // const {rows} = await User.bulkCreate(usersArray);

    const {rows: users} = await User.findAll();
    const phones = await Phone.bulkCreate(generatePhones(100));

    const orders = await Order.bulkCreate(users, phones)

    await client.end();

}


start();