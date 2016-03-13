var http = require("http");
var url = require("url");
var querystring = require('querystring');
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
            var post = querystring.parse(postData);
            if(post.To && post.From && post.Body)
                route(handle, pathName, response, post);
            else if(pathName === "/request")
                route(handle, pathName, response, postData);
            else
                route(handle, "/start", response, postData);
        });
    }
    http.createServer(onRequest).listen(process.env.PORT);
}

exports.start = start;
