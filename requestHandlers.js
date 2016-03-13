var mapsStuff = require('./mapsStuff');
var twilioComp = require('./twilioComp');

function textResponse(response, postData) {
    console.log("request handler textResponse called");
    if(/^send me home fam/i.test(postData.Body)) {
        response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
        var arr = postData.Body.match(/-?\d+\.?\d*/g);
        console.log(arr);
        var arr2 = arr.map(parseFloat);
        console.log(arr2);
        mapsStuff.getDirs({lat: arr2[0], lng: arr2[1]}, {lat: arr2[2], lng: arr2[3]}, response);
    }

    else if(/^find my fam/i.test(postData.Body)) { // user sends text , find my fam 'phonenumber'
        var target = postData.Body.match(/+\d{10}/)[0];
        twilioComp.(target, 'Go to the find my fam app to verify that ' + postData.From + ' is your fam!');
        response.end();
    }
    else {
        response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
        var directionsString = "No handler for request, to: " + postData.To + " From: " + postData.From + " body: " + postData.Body;
        response.write(directionsString);
        response.end();
    }
}

function start(response, postData) {
    console.log("request handler start called");
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    response.write("lo");
    response.end();
}

exports.textResponse = textResponse;
exports.start = start;
