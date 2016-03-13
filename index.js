var server = require("./server");
var router = require("./router");
var requestHandlers = require("./requestHandlers");

var handle = {};
handle["/"] = requestHandlers.textResponse;
handle["/start"] = requestHandlers.start;
handle["/request"] = requestHandlers.request;

console.log("SERVER IS ABOUT TO START!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

server.start(router.route, handle);
