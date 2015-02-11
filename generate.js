var hb = require('handlebars');
var fs = require('fs');
var _  = require('lodash');


var db_json = JSON.parse(fs.readFileSync( process.argv[2] , "utf8"));

var fileIO = {};

fileIO.writeFile = function(fileName, stringText) {
    fs.writeFile(fileName, stringText, function(err) {
        if (err) return console.log(err);
        //console.log('write error ' + fileName);
    });
};


fileIO.openFile = function(fileName)
{
    return fs.readFileSync(fileName, "utf8");
};

hb.registerHelper('csv', function(context) {
    var ret = "";
    for (var i = 0, j = context.length; i < j; i++) {
        ret = ret + "'" + (context[i]) + "'";
        if (i < (j - 1)) ret = ret + ', ';
    }
    return ret;
});

hb.registerHelper('toLowerCase', function(value) {
    if(value) {
        return new hb.SafeString(value.toLowerCase());
    } else {
        return '';
    }
});

hb.registerHelper('ucFirst', function(value) {
    if(value) {
        return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
    } else {
        return '';
    }
});


hb.registerHelper('ife', function(value, valueb) {
    if(value) {
        return new hb.SafeString( valueb );
    } else {
        return '';
    }
});

hb.registerHelper('ifc', function(v1, v2, options) {
  if(v1 === v2) {
    return options.fn(this);
  }
  return options.inverse(this);
});


var generateView = function(model)
{

    var template_var = model;


    var template = fileIO.openFile("./template/view.php.tpl");
    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);

    return pageText;

};



var generateMigration = function(model)
{

    var template_var = model;

    var template = fileIO.openFile("./template/migration.php.tpl");
    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);

    return pageText;


};


var generateDBseederMain = function (model)
{
    var template_var = model;

    var template = fileIO.openFile("./template/seeder.php.tpl");    
    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);
    return pageText;    
};

var generateSeeding = function(model)
{
    var seeds_source = model.seeding;
    var columns = model.column;

    var template_var = {};

    var seeds = [];

    var template = fileIO.openFile("./template/seed.php.tpl");


    for (var i = seeds_source.length - 1; i >= 0; i--) {
        var row = {};
        for (var j = seeds_source[i].length - 1; j >= 0; j--) {
            row[columns[j].name] = seeds_source[i][j].content;
        }
            seeds.push(row);
    }

    template_var.seeds = seeds;
    template_var.model = model;

    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);

    return pageText;
};

var generateController = function(model) {

    var template_var = model;

    var template = fileIO.openFile("./template/controller.php.tpl");
    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);

    return pageText;

};

var generateModel = function(model) {

    var columns = model.column;
    var _relations = model.relation;

    var _fillable = [];
    var _guarded = [];
    var _visible = [];
    var _hidden = [];

    _(columns).forEach(function(col) {
        if (col.fillable === true) _fillable.push(col.name);
        if (col.guarded === true) _guarded.push(col.name);
        if (col.visible === true) _visible.push(col.name);
        if (col.hidden === true) _hidden.push(col.name);
    }).value();

    var template_var = {
        fillable: _fillable,
        guarded: _guarded,
        visible: _visible,
        hidden: _hidden,
        namespace: "App",
        softdelete: false,
        relations: _relations,
        model: model        
    };

    //console.log(model_test.column);
    var template = fileIO.openFile("./template/model.php.tpl");

    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);

    return pageText;
};


var getTimeFile = function() {

    var d = new Date();
    var curr_date = d.getDate();
    var curr_month = d.getMonth();
    var curr_year = d.getFullYear();
    var curr_hour = d.getHours().toString();
    var curr_min = d.getMinutes().toString();
    var curr_sec = d.getSeconds().toString();

    return (curr_year + '_' + curr_month + "_" + curr_date + '_' + curr_hour + curr_min + curr_sec);
};

var     curr_time = getTimeFile();

if ( process.argv[3] === 'notime') {
    curr_time = "";
}

_(db_json).forEach(function(mod){
   fileIO.writeFile('./build/models/' + mod.classname + '.php', generateModel(mod));
   fileIO.writeFile('./build/controllers/' + mod.classname  + 'Controller' + '.php', generateController(mod));
   fileIO.writeFile('./build/migrations/'  + curr_time + '_' + 'create' + '_' + mod.name.toLowerCase() + '_' + 'table'  + '.php', generateMigration(mod));   
   fileIO.writeFile('./build/seeds/'  +  mod.name.toLowerCase() + '_' + 'seed'  + '.php', generateSeeding(mod));   
   fileIO.writeFile('./build/views/'  +  mod.classname.toLowerCase() + '.' + 'blade'  + '.php', generateView(mod));   

}).value();

   fileIO.writeFile('./build/seeds/'  +  'DatabaseSeeder'  + '.php', generateDBseederMain(db_json));   


//console.log(model);
