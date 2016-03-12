var http = require("http");
var url = require("url");
var twiliotest = require("./twiliotest");


function start(route, handle) {
    function onRequest(request, response) {
        var postData = "";
        var pathName = url.parse(request.url).pathname;
        console.log("Request for " + pathName + " received.");

        request.setEncoding("utf8");

        request.addListener("data", function(postDataChunk) {
            postData += postDataChunk;
            console.log("Receiver datachunk " + postDataChunk + ".");
        });

        request.addListener("end", function() {
            route(handle, pathName, response, postData);
        });
        
    }
    http.createServer(onRequest).listen(5000);
}

exports.start = start;
