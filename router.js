function route(handle, pathname, response, postData) {
    console.log("Routing request for " + pathname);
    if(typeof handle[pathname] === 'function') {
        handle[pathname] (response, postData);
    }
    else {
        console.log("No request handler");
        response.writeHead(404, {"Content-Type": "text/plain"});
        response.write("404 Not found");
        response.end();
    }
}

exports.route = route;
