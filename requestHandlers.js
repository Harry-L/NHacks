var mapsStuff = require('./mapsStuff');

function textResponse(response, postData) {
    console.log("request handler textResponse called");
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    if(/^send me help fam/i.test(postData.Body)) {
        var arr = postData.Body.match(/-?\d*.*\d*/g);
        console.log(arr);
        var arr2 = Array.prototype.map.call(arr, parseFloat);
        console.log(arr2);
        mapsStuff.getDirs({lat: arr2[0], lng: arr2[1]}, {lat: arr2[2], lng: arr2[3]}, response);
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
