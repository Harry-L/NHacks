var accSid = "ACe750bf0cc2e09c20b8a67262b968fcef";
var authToken = "01eff6b1be1aacd40cb1877c3170188b";
var client = require('twilio')(accSid, authToken);

var resp = new require('twilio').TwimlResponse();

function sendText() {
    console.log("sending text");
    client.messages.create({
        to: '+16477854379',
        from: '+12897960937',
        body: 'testing123'
    }, function(error, message) {
        if(error)
            console.log(error.message);
    });
}

exports.sendText = sendText;
