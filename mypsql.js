var pg = require('pg');
var dUrl = process.env.DATABASE_URL;

function set(phone, lat, lng, fam, isLook) {

    pg.defaults.ssl = true;
    pg.connect(dUrl, function(err, client, done) {
        if(err) {
            console.log("error fetching client from pool");
        }
        else {
            var boolStr = isLook? "TRUE": "FALSE";
            var temp = client.query("UPDATE famtable SET lastlat=" + lat + ", lastlng=" + lng + ", famPhone='" + fam + "', isLooking=" + boolStr + "  WHERE phone='" + phone + "'");
            console.log(temp);
            done();
        }
    });
}

function add(phone, lat, lng, fam, isLook) {

    pg.defaults.ssl = true;
    pg.connect(dUrl, function(err, client, done) {
        if(err) {
            console.log("error fetching client from pool");
        }
        else {
            var temp = client.query("SELECT phone FROM famtable WHERE phone='" + phone + "'");
            temp.on('end', function(result) {
                if(result.rowCount) {
                    set(phone, lat, lng, fam, isLook);
                }
                else {
                    var boolStr = isLook? "TRUE": "FALSE";
                    var temp2 = client.query("INSERT INTO famtable VALUES ('" + phone + "', " + lat + ", " + lng + ", '" + fam + "', " + boolStr +")");
                }
            });
            done();
        }
    });
}

function get(phone, callback) {

    pg.defaults.ssl = true;
    pg.connect(dUrl, function(err, client, done) {
        if(err) {
            console.log("error fetching client from pool");
        }
        else {
            var temp = client.query("SELECT lastlat, lastlng, famPhone, isLooking FROM famtable WHERE phone='" + phone + "'");
            var row2;
            temp.on('row', function(row) {
                row2 = row;
            });
            temp.on('end', function(result) {
                console.log(row2);
                console.log(result);
                done();
                callback(row2);
            });
        }
    });
}

function resetFam(phone) {
    
    pg.defaults.ssl = true;
    pg.connect(dUrl, function(err, client, done) {
        if(err) {
            console.log("error fetching client from pool");
        }
        else {
            var temp = client.query("UPDATE famtable SET famPhone='', isLooking=FALSE WHERE phone='" + phone + "'");
            console.log(temp);
            done();
        }
    });
}

function updateLoc(phone, lat, lng) {

    pg.defaults.ssl = true;
    pg.connect(dUrl, function(err, client, done) {
        if(err) {
            console.log("error fetching client from pool");
        }
        else {
            var temp = client.query("SELECT phone FROM famtable WHERE PHONE='" + phone + "'");
            temp.on('end', function(result) {
                if(result.rowCount) {
                    var temp2 = client.query("UPDATE famtable SET lastlat=" + lat + ", lastlng=" + lng + " WHERE phone='" + phone + "'");
                }
                else {
                    add(phone, lat, lng, "", false);
                }
            });
            done();
            console.log(temp);
        }
    });
}


exports.add = add;
exports.set = set;
exports.get = get;
exports.updateLoc = updateLoc;
exports.resetFam = resetFam;
