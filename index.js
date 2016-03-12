var server = require("./server");
var router = require("./router");
var requestHandlers = require("./requestHandlers");

var handle = {};
handle["/"] = requestHandlers.textResponse;
handle["/start"] = requestHandlers.start;

console.log("wtf");

server.start(router.route, handle);
