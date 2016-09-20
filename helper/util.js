var fs = require('fs-extra');


var util = {};
util.fileIO = {};


util.replaceWithHash = function(str, hash) {
    var string = str,
        key;
    for (key in hash) string = string.replace(new RegExp('\\{' + key + '\\}', 'gm'), hash[key]);
    return string;
}


util.readJsonFromFile = function(filename) {
    return JSON.parse(fs.readFileSync(filename, "utf8"));
}

util.getTimeFile = function() {

    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth();
    var curr_year = d.getFullYear();
    var curr_hour = d.getHours().toString();
    var curr_min = d.getMinutes().toString();
    var curr_sec = d.getSeconds().toString();

    return (curr_year + '_' + curr_month + "_" + curr_date + '_' + curr_hour + curr_min + curr_sec);
};


util.fileIO.writeFile = function(fileName, stringText) {
    fs.ensureFile(fileName, function(){
            fs.writeFile(fileName, stringText, function(err) {
        if (err) return console.log(err);
        //console.log('write error ' + fileName);
    });
    });

};



util.fileIO.openFile = function(fileName) {
    return fs.readFileSync(fileName, "utf8");
};


module.exports = util