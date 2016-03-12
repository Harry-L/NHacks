function start(response, postData) {
    console.log("request handler start called");
    response.writeHead(200, {"Content-Tyoe": "text/plain", "Access-Control-Allow-Origin": "*"});
    response.write("lo");
    response.end();
}

exports.start = start;
