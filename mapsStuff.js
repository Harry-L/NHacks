var request = require('request');
var fs = require('fs');

// returns obj with lat, lng properties
function geocode(loc) {
    fs.readFile('keys/mapsApi', 'utf8', function(error, apikey) {
        var locComp = loc.split().join('+');
        request.post('https://maps.googleapis.com/maps/api/geocode/json?address=' + locComp + '&key=' + apikey, 
            function(error, response, body) {
                if(!error && response.statusCode == 200) {
                    var bodyObj = JSON.parse(body);
                    console.log(bodyObj);
                    if(bodyObj.results && bodyObj.results[0]) {
                        return bodyObj.results[0].geometry.location;
                    }
                    return { lat: 0, lng: 0};
                }
            });
    });
}

// returns formatted address from lat/long
function revGeocode(lat, lng) {
    fs.readFile('keys/mapsApi', 'utf8', function(error, apikey) {
        request.post('https://maps.googleapis.com/maps/api/geocode/json?latlng=' + lat + ',' + lng + '&key=' + apikey, 
            function(error, response, body) {
                var formatted = "";
                if(!error && response.statusCode == 200) {
                    var bodyObj = JSON.parse(body);
                    if(bodyObj.results && bodyObj.results[0])
                        formatted = bodyObj.results[0].formatted_address;
                }
                return formatted;
            });
    });   
}

function getDirs(orig, dest, texthandle) {

    fs.readFile('keys/mapsApi', 'utf8', function(error, apikey) {
        var reqUrl = 'https://maps.googleapis.com/maps/api/directions/json?'
        if(typeof orig === 'string')
            reqUrl += 'origin=' + orig.split().join('+');
        else
            reqUrl += 'origin=' + orig.lat + ',' + orig.lng;

        if(typeof dest === 'string')
            reqUrl += '&destination=' + dest.split().join('+');
        else
            reqUrl += '&destination=' + dest.lat + ',' + dest.lng;
        reqUrl += '&mode=walking';
        reqUrl += '&key=' + apikey;

        console.log("url: " + reqUrl);

        request.post(reqUrl,
            function(error, response2, body) {
                if(!error && response2.statusCode == 200) {
                    console.log("no error, status code fine");
                    var bodyObj = JSON.parse(body);
                    if(bodyObj && bodyObj.routes && bodyObj.routes[0]) {
                        console.log("bodyObj.routes[0] defined");
                        var responseString = "";
                        var steps = bodyObj.routes[0].legs[0].steps;
                        var total = "";
                        steps.forEach(function(step) {
                            var instructions = step.html_instructions;
                            instructions = instructions.replace(/(\<)(.*?)(\>)/g, "");
                            instructions += ' for: ' + step.distance.value + 'm, ' + step.duration.text + '\n';
                            total += instructions;
                        });
                        if(total.length < 1600)
                            texthandle(total);
                        else
                            texthandle("Directions are too long to be sent via text fam, good luck.");
                    }
                    else {
                        texthandle('undefined behaviour');
                    }
                }
            });
    });
}

//geocode('1600 Amphitheatre Parkway, Mountain View, CA');
//revGeocode(42.948881,-81.24862);

//getDirs('142 Sunfield Rd, Toronto, ON M3M 3J3', '20 Tillplain Rd, Toronto, ON M3H 5R2');

exports.getDirs = getDirs;
