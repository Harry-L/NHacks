var mapsStuff = require('./mapsStuff');

function textResponse(response, postData) {
    console.log("request handler textResponse called");
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    if(/^send me help fam/i.test(postData.Body)) {
        var arr = postData.Body.match(/curr:\s*(-*\d*.*\d*\s+-*\d*.*\d*)/);
        console.log(arr);
        arr += postData.Body.match(/dest:\s*(-*\d*.*\d*\s+-*\d*.*\d*)/);
        var arr2 = arr[1].split() + arr[3].split();
        arr = arr2.map(parseFloat);
        console.log(arr);
        mapsStuff.getDirs({lat: arr[0], lng: arr[1]}, {lat: arr[2], lng: arr[3]}, response);
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
