
const {mapUsers} = require('./mapUsers');
const configs = require('./configs/db');
const {getUsers} = require('./api/index');
const {User} = require('./models/index')



const client = new Client(configs);


async function start() {
    await client.connect();

    const usersArray = await getUsers();

    const {rows} = await User.bulkCreate(usersArray);

    await client.end();

}


start();