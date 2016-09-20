var fs = require('fs-extra')
var _  = require('lodash')
var hb  = require('./helper/handlebar.js')
var util = require('./helper/util.js')

var template_variables = require('./variables')

var generatorApp = {}
var generatorSettings = {}
generatorSettings.output = "./build-test"

/// template
generatorApp.readConfigFromFile = function(def_directory) {
    var config = util.readJsonFromFile(def_directory + "/definition.js")
    var path_hash = config.path
    var template_table = config.table
    var template_main = config.main
    var template_fields = config.fields

    var curr_time = util.getTimeFile()
    if (process.argv[3] === 'notime') {
        curr_time = ""
    }

    path_hash.filetime = curr_time //util.getTimeFile()

    var replaceConfigHash = function(config_element, config_path_hash)
    {
        config_element.src = util.replaceWithHash(config_element.src, config_path_hash)
        config_element.dst =  util.replaceWithHash(config_element.dst, config_path_hash)
        config_element.filename = util.replaceWithHash(config_element.filename, config_path_hash)
        config_element.build =  hb.compile(util.fileIO.openFile(def_directory + "/" +config_element.src))
        console.log(config_element.dst)
    }

    replaceConfigHash(config.routes, path_hash)

    _.forEach(template_fields, function(template) {
        replaceConfigHash(template, path_hash)
    })

    _.forEach(template_table, function(template) {
        replaceConfigHash(template, path_hash)
    })

    _.forEach(template_main, function(template) {
        replaceConfigHash(template, path_hash)
    })

    return config
}


generatorApp.generateRelation = function(model) {
    var relation_array = {}
    _(model.relation).forEach(function(relation) {

        var table = _.findWhere(generatorSettings.skema, {
            classname: relation.relatedmodel
        })

        var column = []
        var column_full = []

        _(table.column).forEach(function(col) {
            column.push(col.name)
        }).value()

        _(table.column).forEach(function(col) {
            column_full.push(col)
        }).value()

        if (typeof relation_array[relation.relationtype] === 'undefined') relation_array[relation.relationtype] = []
        relation_array[relation.relationtype].push({
            'relatedcolumn': relation.relatedcolumn,
            'relatedmodel': relation.relatedmodel,
            'table_name': table.name.toLowerCase(),
            'table_class': table.classname.toLowerCase(),
            'relation_name': relation.name,
            'foreignkeys': relation.relatedmodel.toLowerCase(),
            'column': column,
            'column_full' : column_full
        })

    }).value()

    return relation_array
}

generatorApp.addRelationToColumn = function(model) {

    //auto detect relation based on column name
    _.forEach(model.column, function(item) {
        if (item.name.substr(-3, 3) == '_id') {
            var rel_to_find = item.name.substr(0, item.name.length - 3)
            var rel = _.findWhere(model.relation, {
                name: rel_to_find
            })
            if (rel.relationtype === "belongsTo") {
                item.relation = rel
            }
        }
    })

}

generatorApp.addSeedingToColumn = function(model) {
    // var seeds_source = model.seeding
    // var columns = model.column

    // var template = util.fileIO.openFile("./template/seed.php.tpl")
    // var template_var = model
    // var seeds = []

    // for (var i = seeds_source.length - 1 i >= 0 i--) {
    //     var row = {}
    //     for (var j = seeds_source[i].length - 1 j >= 0 j--) {
    //         row[columns[j].name] = seeds_source[i][j].content
    //     }
    //     seeds.push(row)
    // }

    // template_var.seeds = seeds
}

generatorApp.addModelAttribToColumn = function(model) {
    var columns = model.column
    var relations = model.relation

    var _fillable = []
    var _guarded = []
    var _visible = []
    var _hidden = []

    _(columns).forEach(function(col) {
        if (col.fillable === true) _fillable.push(col.name)
        if (col.guarded === true) _guarded.push(col.name)
        if (col.visible === true) _visible.push(col.name)
        if (col.hidden === true) _hidden.push(col.name)
    }).value()

    var model_var = {
        fillable: _fillable,
        guarded: _guarded,
        visible: _visible,
        hidden: _hidden,
        namespace: "App",
        softdelete: model.softdelete,
        relations: relations,
    }

    model.model = model_var
}

generatorApp.compileTemplateToString = function(template_builder, template_var) {
    return template_builder(template_var)
}


generatorApp.injectTemplateVariable = function(schema) {
    _.forEach(schema, function(model) {
        model.relation_array = generatorApp.generateRelation(model)
        generatorApp.addRelationToColumn(model)
        generatorApp.addSeedingToColumn(model)
        generatorApp.addModelAttribToColumn(model)
    })
}


generatorApp.concatMemberName = function(array, name)
{
    var tmp = []
    _.forEach(array, function(member) { 
        tmp.push(member[name])
    })

    return tmp
}

generatorApp.concatMemberKeyValue = function(array, name, value)
{
    var tmp = []
    _.forEach(array, function(member) { 
        tmp.push("\t\'" + member[name] + "\'" +  ' => ' + "\'" + member[value] + "\'")
    })

    return tmp.join(',\n')
}

generatorApp.joinArray = function(array)
{
    var tmparr = _.map(array, function(member){ return "\t\'" + member + "\'"  })
    return tmparr.join(',\t\n')
}

generatorApp.writeTemplate = function(schema, templates) {

    var template_routes = ""
    
    schema.ROUTES_COMPILED = ""

    _.forEach(schema, function(entity) {

        var infyom = _.clone(template_variables)

        infyom.MODEL_NAME = entity.classname
        infyom.TABLE_NAME = entity.name
        infyom.FIELDS = generatorApp.joinArray(entity.model.fillable)
        infyom.CAST = generatorApp.concatMemberKeyValue(entity.column, 'name', 'type')

        if (entity.softdelete === false)
        {
            infyom.SOFT_DELETE_IMPORT = ""
            infyom.SOFT_DELETE = ""
            infyom.SOFT_DELETE_DATES = ""
        }

        infyom.MODEL_NAME = entity.classname
        infyom.MODEL_NAME_CAMEL = entity.classname
        infyom.MODEL_NAME_PLURAL_CAMEL = entity.classname
        infyom.MODEL_NAME_PLURAL_SNAKE = entity.classname
        infyom.MODEL_NAME_HUMAN = entity.classname

        //template each item fields
        var template_fields = ""
        var field_headers = ""
        var field_body = ""
        var field_body = ""
        var show_fields = ""

        _.forEach(entity.column, function(item) {

            infyom.FIELD_NAME = item.name
            infyom.FIELD_NAME_TITLE = item.name

            if ( item.type === 'string' ) {
                template_fields += templates.fields.text.build(infyom)
                template_fields += "\n\n"
            }

            field_headers += templates.fields.field_headers.build(infyom) + "\n"
            field_body += templates.fields.field_body.build(infyom) + "\n"
            show_fields += templates.fields.show_field.build(infyom) + "\n\n"

        })

        //store compiled fields template
        infyom.FIELDS_COMPILED = template_fields
        infyom.FIELD_HEADERS = field_headers
        infyom.FIELD_BODY = field_body
        infyom.SHOW_FIELDS = show_fields

        //merge configuration to our schema
        _.merge(entity, infyom)

        schema.ROUTES_COMPILED += templates.routes.build(entity) + "\n"


    })

    //console.log("")
    //console.log("Processing " + table.name + " table template")
    //console.log("---------------------------------------")
    // controller, model, view, repo templates

    _.forEach(schema, function(entity) {
        var file_hash = {
            classname: entity.classname.toLowerCase(),
            uclassname: entity.classname,
            name: entity.name.toLowerCase()
        }
        //save each template
        _.forEach(templates.table, function(template) {
            var compiled_template = generatorApp.compileTemplateToString(template.build, entity)            
            var template_filename = util.replaceWithHash(template.filename, file_hash)
            // console.log("Writing " + template.name + " to " + template.dst + template_filename)
            util.fileIO.writeFile(generatorSettings.output + "/" + template.dst + "/" + template_filename, compiled_template)
            // console.log(generatorSettings.output + "/" + template.dst + "/" + template_filename)
           console.log(template.dst)
        })
    })

    console.log("")
    console.log("")

    console.log("Processing main template")
    console.log("---------------------------------------")

    _.forEach(templates.main, function(template) {
        var compiled_template = generatorApp.compileTemplateToString(template.build, schema)
        //console.log("Writing " + template.name + " to " + template.dst + template.filename)
        util.fileIO.writeFile(generatorSettings.output + "/" + template.dst + "/" + template.filename, compiled_template)
    })
    console.log("")
}

var template_config = generatorApp.readConfigFromFile("./template/infyom/5.3")

generatorSettings.skema = util.readJsonFromFile(process.argv[2])
generatorSettings.output = process.argv[3]

generatorApp.injectTemplateVariable(generatorSettings.skema)
generatorApp.writeTemplate(generatorSettings.skema, template_config)


console.log("done....\n")