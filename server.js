var http = require("http");
var url = require("url");
var twilioComp = require("./twilioComp");


function start(route, handle) {
    function onRequest(request, response) {
        if(request.to && request.from && request.body) {
            response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
            response.write(request.to + " " + request.from + " " + request.body);
            response.end();
        }

        else {
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
    }
    http.createServer(onRequest).listen(process.env.PORT);
}

exports.start = start;
