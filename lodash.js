var _  = require('lodash');
var fs = require('fs');
var m = require('marko');


//_.templateSettings.interpolate = /\{\{([\s\S]+?)\}\}/g;

//_.templateSettings.interpolate = /<%=([\s\S]+?)%>/g;
_.templateSettings.interpolate = /{{([\s\S]+?)}}/g;

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



var generateRelation = function(model)
{
    var relation_array = {};

    _(model.relation).forEach(function(relation) {  
        var column = [];      
        var table = _.findWhere(db_json, {classname: relation.relatedmodel});

        _(table.column).forEach(function(col) {
            column.push(col.name);
        }).value();        


        if ( typeof relation_array[relation.relationtype] === 'undefined') relation_array[relation.relationtype] = [];
        relation_array[relation.relationtype].push(
          { 
            'relatedmodel' : relation.relatedmodel,            
            'table_name' : table.name.toLowerCase(),
            'relation_name' : relation.name,
            'foreignkeys' : relation.relatedmodel.toLowerCase()
            'column' : column
          }
        );
    }).value();
    return relation_array;
};

var generateController = function(model) {

    var template_var = model;
    var relation_array = generateRelation(model);

    if (template_var.namespace === '') {
        template_var.namespace_path = "App";
    }else{
        template_var.namespace_path = template_var.namespace ;
    };

    template_var.relation_array = relation_array;

    var template = fileIO.openFile("./template/test.tpl");
	var compiled = _.template(template);

    return compiled(template_var);
};


var db_json = JSON.parse(fs.readFileSync( "skema/Akun2.skema" , "utf8"));

//console.log(db_json);
var model = db_json[0];

//console.log(model);

console.log(generateController(model));


