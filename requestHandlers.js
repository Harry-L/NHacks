var mapsStuff = require('./mapsStuff');
var twilioComp = require('./twilioComp');
var mypsql = require('./mypsql');

function textResponse(response, postData) {
    console.log("request handler textResponse called");
    if(/^send me home fam/i.test(postData.Body)) {
        var arr = postData.Body.match(/-?\d+\.?\d*/g);
        console.log(arr);
        if(arr.length != 4) {
            sendError('Bad arguments!', response);
        }
        else {
            var arr2 = arr.map(parseFloat);
            console.log(arr2);
            mypsql.updateLoc(postData.From, arr2[0], arr2[1]);
            mapsStuff.getDirs({lat: arr2[0], lng: arr2[1]}, {lat: arr2[2], lng: arr2[3]}, function(text) {sendError(text, response);});
        }
    }

    else if(/^find my fam/i.test(postData.Body)) { // user sends text , find my fam 'phonenumber'
        var target = postData.Body.match(/\+\d{11}/)[0];
        var arr = postData.Body.match(/-?\d+\.?\d*/g);
        var arr2 = arr.map(parseFloat);
        arr = arr2.filter(function(num) {return num <= 1000});
        if(!target || arr.length != 2) {
            sendError('Bad arguments!', response); 
        }
        else {
            twilioComp.sendText(target, 'Go to the find my fam app to verify that ' + postData.From + ' is your fam!');
            sendError('Find my fam request sent!', response);
            mypsql.add(postData.From, arr[0], arr[1], target, true);
        }
    }
    else if(/^bring my fam/i.test(postData.Body)) { // fam sends text , bring my fam 'phonenumber'
        var target = postData.Body.match(/\+\d{11}/);
        var arr = postData.Body.match(/-?\d+\.?\d*/g);
        var arr2 = arr.map(parseFloat);
        arr = arr2.filter(function(num) { return num <= 1000});
        console.log(arr);
        console.log(target);
        if(!target || arr.length != 2) {
            sendError('Bad arguments!', response);
        }
        else {
            mypsql.get(target, function(result) {
                if(result.islooking && result.famphone === postData.From) {
                    mapsStuff.getDirs({lat: result.lastlat, lng: result.lastlng}, {lat: arr[0], lng: arr[1]}, function(text) {twilioComp.sendText(target, text);});
                    sendError('Your fam will be fine!', response);
                    mypsql.resetFam(target);
                }
                else {
                    sendError('Your fam is fine!', response);
                }
                
            });
        }
    }
    else {
        sendError("No handler for request, to: " + postData.To + " From: " + postData.From + " body: " + postData.Body, response);
    }
}

function sendError(text, response) {
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    response.write(text);
    response.end();
}

function start(response, postData) {
    console.log("request handler start called");
    response.writeHead(200, {"Content-Type": "text/plain", "Access-Control-Allow-Origin": "*"});
    response.write("lo");
    response.end();
}

exports.textResponse = textResponse;
exports.start = start;
