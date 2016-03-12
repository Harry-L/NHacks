var mapsStuff = require('./mapsStuff');

function textResponse(response, postData) {
    console.log("request handler textResponse called");
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    if(/^findmefam/.test(postData.Body)) {
        mapsStuff.getDirs('142 Sunfield Rd, Toronto, ON M3M 3J3', '20 Tillplain Rd, Toronto, ON M3H 5R2', response);
    }
    else {
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
