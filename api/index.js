const API_BASE = 'https://randomuser.me/api/';

module.exports.getUsers = async () => {
    const response = await fetch(`${API_BASE}?results=500&seed=fd-2022`);
    const {results} = await response.json();
    return results;
}