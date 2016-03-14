var fs = require('fs');

function sendText(targetNum, bodyText) {

	fs.readFile('keys/accSid', 'utf8', function(error1, accSid) {
		fs.readFile('keys/authToken', 'utf8', function(error2, authToken) {
			var client = require('twilio')(accSid, authToken);
			var resp = new require('twilio').TwimlResponse();
			console.log("sending text");
    		client.messages.create({
        		to: targetNum,
        		from: '+12897960937',
        		body: bodyText
    		}, function(error, message) {
        		if(error)
            		console.log(error.message);
    		});
		});
	});

    
}

exports.sendText = sendText;
