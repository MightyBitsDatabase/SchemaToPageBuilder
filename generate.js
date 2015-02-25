var hb = require('handlebars');
var fs = require('fs');
var _ = require('lodash');

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
    fs.writeFile(fileName, stringText, function(err) {
        if (err) return console.log(err);
        //console.log('write error ' + fileName);
    });
};



util.fileIO.openFile = function(fileName) {
    return fs.readFileSync(fileName, "utf8");
};


(function() {
    function checkCondition(v1, operator, v2) {
        switch (operator) {
            case '==':
                return (v1 == v2);
            case '===':
                return (v1 === v2);
            case '!==':
                return (v1 !== v2);
            case '<':
                return (v1 < v2);
            case '<=':
                return (v1 <= v2);
            case '>':
                return (v1 > v2);
            case '>=':
                return (v1 >= v2);
            case '&&':
                return (v1 && v2);
            case '||':
                return (v1 || v2);
            default:
                return false;
        }
    }


    hb.registerHelper('csv', function(context) {
        var ret = "";
        for (var i = 0, j = context.length; i < j; i++) {
            ret = ret + "'" + (context[i]) + "'";
            if (i < (j - 1)) ret = ret + ', ';
        }
        return ret;
    });

    hb.registerHelper('toLowerCase', function(value) {
        if (value) {
            return new hb.SafeString(value.toLowerCase());
        } else {
            return '';
        }
    });

    hb.registerHelper('ucFirst', function(value) {
        if (value) {
            return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
        } else {
            return '';
        }
    });

    hb.registerHelper('cameLize', function(value) {
        if (value) {
            var array_val = value.split('_');
            var newval = [];
            _.forEach(array_val, function(val){
                newval.push(val.charAt(0).toUpperCase() + val.slice(1).toLowerCase());
            });     

            return newval.join("");
        } else {
            return '';
        }
    });

    hb.registerHelper('ife', function(value, valueb) {
        if (value) {
            return new hb.SafeString(valueb);
        } else {
            return '';
        }
    });

    hb.registerHelper('ifc', function(v1, v2, options) {
        if (v1 === v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    });


    hb.registerHelper('ifcond', function(v1, operator, v2, options) {
        return checkCondition(v1, operator, v2) ? options.fn(this) : options.inverse(this);
    });
}());

/// template

var readConfigFromFile = function(filename) {
    var config = util.readJsonFromFile(filename);
    var path_hash = config.path;
    var template_table = config.table;
    var template_main = config.main;


    path_hash.filetime = curr_time; //util.getTimeFile();

    _.forEach(template_table, function(template) {
        template.src = util.replaceWithHash(template.src, path_hash);
        template.dst = util.replaceWithHash(template.dst, path_hash);
        template.filename = util.replaceWithHash(template.filename, path_hash);
    });

    _.forEach(template_main, function(template) {
        template.src = util.replaceWithHash(template.src, path_hash);
        template.dst = util.replaceWithHash(template.dst, path_hash);
        template.filename = util.replaceWithHash(template.filename, path_hash);
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


        _(table.column).forEach(function(col) {
            column.push(col.name);
        }).value();


        if (typeof relation_array[relation.relationtype] === 'undefined') relation_array[relation.relationtype] = [];
        relation_array[relation.relationtype].push({
            'relatedcolumn': relation.relatedcolumn,
            'relatedmodel': relation.relatedmodel,
            'table_name': table.name.toLowerCase(),
            'table_class': table.classname.toLowerCase(),
            'relation_name': relation.name,
            'foreignkeys': relation.relatedmodel.toLowerCase(),
            'column': column
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

    var template_var = model;

    var seeds = [];

    var template = util.fileIO.openFile("./template/seed.php.tpl");


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

var compileTemplateToString = function(template_file, column) {
    var template_var = column;
    var template = util.fileIO.openFile(template_file);
    var pageBuilder = hb.compile(template);
    var pageText = pageBuilder(template_var);
    return pageText;
};


var injectTemplateVariable = function(database) {
    _.forEach(database, function(model) {
        model.relation_array = generateRelation(model);
        addRelationToColumn(model);
        addSeedingToColumn(model);
        addModelAttribToColumn(model);
    });
}

var writeTemplate = function(database, templates) {


    _.forEach(database, function(table) {
        console.log("");
        console.log("Processing " + table.name + " table template");
        console.log("---------------------------------------");

        _.forEach(templates.table, function(template) {
            var compiled_template = compileTemplateToString(template.src, table);
            file_hash = {
                classname: table.classname.toLowerCase(),
                uclassname: table.classname,
                name: table.name.toLowerCase()
            };
            var template_filename = util.replaceWithHash(template.filename, file_hash);
            console.log("Writing " + template.name + " to " + template.dst + template_filename);
            util.fileIO.writeFile(template.dst + template_filename, compiled_template);

        });
    });

    console.log("");
    console.log("");

    console.log("Processing main template");
    console.log("---------------------------------------");

    _.forEach(templates.main, function(template) {
        var compiled_template = compileTemplateToString(template.src, database);
        console.log("Writing " + template.name + " to " + template.dst + template.filename);
        util.fileIO.writeFile(template.dst + template.filename, compiled_template);
    });

    console.log("");

}


var curr_time = util.getTimeFile();
if (process.argv[3] === 'notime') {
    curr_time = "";
}

var template_config = readConfigFromFile(process.argv[2]);
var db_json = util.readJsonFromFile(template_config.project.skema);

console.log("\n\n------------------------------");
console.log(template_config.project.name);
console.log("------------------------------");

injectTemplateVariable(db_json);
writeTemplate(db_json, template_config);

console.log("done....\n");

// fileIO.writeFile('./build/seeds/'  +  'DatabaseSeeder'  + '.php', generateDBseederMain(db_json));   
// fileIO.writeFile( routes_path  +  'routes'  + '.php', generateRoute(db_json));   
// fileIO.writeFile(views_path  +  'main_layout' + '.' + 'blade'  + '.php', generateLayoutTemplate(db_json));