module.exports = {
    init: function (success, error) {
        cordova.exec(success, error, 'WatchOSApi', 'init', []);
    },
    getMessages: function (success, error) {
        cordova.exec(success, error, 'WatchOSApi', 'getMessages', []);
    },
    sendMessage: function (msg, success, error) {
        cordova.exec(success, error, 'WatchOSApi', 'sendMessage', [msg]);
    } 
}; 