var http = require("http");
var url = require("url");
var twilioComp = require("./twilioComp");


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
            console.log(postData.To + " " + postData.From + " " + postData.Body);
            console.log(response.To + " " + response.From + " " + response.Body);
            //route(handle, pathName, response, postData);
        });
    }
    http.createServer(onRequest).listen(process.env.PORT);
}

exports.start = start;
