var fs = require('fs-extra');
var _  = require('lodash');
var hb  = require('./handlebar.js');
var util = require('./util.js');

var tmp_controller = require('./controller_template');
var tmp_model = require('./model_template');

/// template
var readConfigFromFile = function(filename) {
    var config = util.readJsonFromFile(filename);
    var path_hash = config.path;
    var template_table = config.table;
    var template_main = config.main;

    var curr_time = util.getTimeFile();
    if (process.argv[3] === 'notime') {
        curr_time = "";
    }

    path_hash.filetime = curr_time; //util.getTimeFile();

    _.forEach(template_table, function(template) {
        template.src = util.replaceWithHash(template.src, path_hash);
        template.dst = util.replaceWithHash(template.dst, path_hash);
        template.filename = util.replaceWithHash(template.filename, path_hash);
        template.build = hb.compile(util.fileIO.openFile(template.src));
    });

    _.forEach(template_main, function(template) {
        template.src = util.replaceWithHash(template.src, path_hash);
        template.dst = util.replaceWithHash(template.dst, path_hash);
        template.filename = util.replaceWithHash(template.filename, path_hash);
        template.build = hb.compile(util.fileIO.openFile(template.src));
    });

    return config;
}


var generateRelation = function(model) {
    var relation_array = {};
    _(model.relation).forEach(function(relation) {

        var table = _.findWhere(db_json, {
            classname: relation.relatedmodel
        });

        var column = [];
        var column_full = [];

        _(table.column).forEach(function(col) {
            column.push(col.name);
        }).value();

        _(table.column).forEach(function(col) {
            column_full.push(col);
        }).value();

        if (typeof relation_array[relation.relationtype] === 'undefined') relation_array[relation.relationtype] = [];
        relation_array[relation.relationtype].push({
            'relatedcolumn': relation.relatedcolumn,
            'relatedmodel': relation.relatedmodel,
            'table_name': table.name.toLowerCase(),
            'table_class': table.classname.toLowerCase(),
            'relation_name': relation.name,
            'foreignkeys': relation.relatedmodel.toLowerCase(),
            'column': column,
            'column_full' : column_full
        });

    }).value();

    return relation_array;
};

var addRelationToColumn = function(model) {

    //auto detect relation based on column name
    _.forEach(model.column, function(item) {
        if (item.name.substr(-3, 3) == '_id') {
            var rel_to_find = item.name.substr(0, item.name.length - 3);
            var rel = _.findWhere(model.relation, {
                name: rel_to_find
            });
            if (rel.relationtype === "belongsTo") {
                item.relation = rel;
            };
        };
    });

};

var addSeedingToColumn = function(model) {
    var seeds_source = model.seeding;
    var columns = model.column;

    var template = util.fileIO.openFile("./template/seed.php.tpl");
    var template_var = model;
    var seeds = [];

    for (var i = seeds_source.length - 1; i >= 0; i--) {
        var row = {};
        for (var j = seeds_source[i].length - 1; j >= 0; j--) {
            row[columns[j].name] = seeds_source[i][j].content;
        }
        seeds.push(row);
    }

    template_var.seeds = seeds;
};

var addModelAttribToColumn = function(model) {

    var columns = model.column;
    var relations = model.relation;

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

    var model_var = {
        fillable: _fillable,
        guarded: _guarded,
        visible: _visible,
        hidden: _hidden,
        namespace: "App",
        softdelete: false,
        relations: relations,
    };

    model.model = model_var;
};

var compileTemplateToString = function(template_builder, template_var) {
    return template_builder(template_var);
};


var injectTemplateVariable = function(database) {
    _.forEach(database, function(model) {
        model.relation_array = generateRelation(model);
        addRelationToColumn(model);
        addSeedingToColumn(model);
        addModelAttribToColumn(model);
    });
}


var concatMemberName = function(array, name)
{
    var tmp = [];
    _.forEach(array, function(member) { 
        tmp.push(member[name])
    })

    return tmp;
}

var joinArray = function(array)
{
    var tmparr = _.map(array, function(member){ return "\'" + member + "\'" ; });
    return tmparr.join(',\n')
}

var writeTemplate = function(database, templates) {

    _.forEach(database, function(entity) {

        //console.log("");
        //console.log("Processing " + table.name + " table template");
        //console.log("---------------------------------------");


        // controller, model, view, repo templates
        _.forEach(templates.table, function(template) {
            
            if (template.name === 'model') 
                {
                    var new_model = _.clone(tmp_model)
    
                    new_model.MODEL_NAME = entity.classname
                    new_model.TABLE_NAME = entity.name
                    new_model.FIELDS = joinArray(entity.model.fillable)

                    console.log('model --->', new_model)
                }

            if (template.name === 'controller') 
                {
                    //console.log(entity.name, entity.column)
                }

            var compiled_template = compileTemplateToString(template.build, entity);
            
            file_hash = {
                classname: entity.classname.toLowerCase(),
                uclassname: entity.classname,
                name: entity.name.toLowerCase()
            };

            var template_filename = util.replaceWithHash(template.filename, file_hash);
            //console.log("Writing " + template.name + " to " + template.dst + template_filename);
            //util.fileIO.writeFile(template.dst + template_filename, compiled_template);

        });
    });

    console.log("");
    console.log("");

    console.log("Processing main template");
    console.log("---------------------------------------");

    _.forEach(templates.main, function(template) {
        var compiled_template = compileTemplateToString(template.build, database);
        console.log("Writing " + template.name + " to " + template.dst + template.filename);
        //util.fileIO.writeFile(template.dst + template.filename, compiled_template);
    });

    console.log("");

}

var template_config = readConfigFromFile(process.argv[2]);
var db_json = util.readJsonFromFile(template_config.project.skema);

console.log("\n\n------------------------------");
console.log(template_config.project.name);
console.log("------------------------------");

injectTemplateVariable(db_json);
writeTemplate(db_json, template_config);


console.log("done....\n");