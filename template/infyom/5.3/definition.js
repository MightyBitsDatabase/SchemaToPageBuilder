{
    "path": {
        "template_path": "/template",
        "laravel_path": "",
        "view_path": "resources/views",
        "model_path": "app/Models",
        "controller_path": "/app/Http/Controllers",
        "route_path": "app/Http/",
        "migration_path": "migrations",
        "seed_path": "seeds"
    },
    "fields": {
        "text": {
            "src": "{template_path}/fields/text.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{uclassname}.text.stub"
        },
        "field_headers": {
            "src": "{template_path}/views/table_header.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{uclassname}.text.stub"            
        },
        "field_body": {
            "src": "{template_path}/views/table_cell.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{uclassname}.text.stub"            
        },
        "show_field": {
            "src": "{template_path}/views/show_field.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{uclassname}.text.stub"            
        }                         
    },
    "routes": {
            "src": "{template_path}/routes/routes.php.tpl",
            "dst": "{laravel_path}/{route_path}",
            "filename": "web.php"
    },
    "table": [
        {
            "name" : "show_fields",
            "src": "{template_path}/views/show_fields.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/show_fields.blade.php"
        },        
        {
            "name" : "table",
            "src": "{template_path}/views/blade_table_body.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/table.blade.php"
        },
        {
            "name" : "show",
            "src": "{template_path}/views/show.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/show.blade.php"
        },
        {
            "name" : "index",
            "src": "{template_path}/views/index.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/index.blade.php"
        },
        {
            "name" : "create",
            "src": "{template_path}/views/create.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/create.blade.php"
        },
        {
            "name" : "edit",
            "src": "{template_path}/views/edit.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/edit.blade.php"
        },        
        {
            "name" : "fields",
            "src": "{template_path}/views/fields.stub",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{classname}/fields.blade.php"
        },
        {
            "name": "request_create",
            "src": "{template_path}/request/create_request.php.tpl",
            "dst": "{laravel_path}//app/Http/Requests/",
            "filename": "Create{uclassname}Request.php"
        },    
        {
            "name": "request_update",
            "src": "{template_path}/request/update_request.php.tpl",
            "dst": "{laravel_path}//app/Http/Requests/",
            "filename": "Update{uclassname}Request.php"
        },    
        {
            "name": "model",
            "src": "{template_path}/model.php.tpl",
            "dst": "{laravel_path}/{model_path}",
            "filename": "{uclassname}.php"
        },
        {
            "name": "controller",
            "src": "{template_path}/controller/controller.php.tpl",
            "dst": "{laravel_path}/{controller_path}",
            "filename": "{uclassname}Controller.php"
        },
        {
            "name": "repository",
            "src": "{template_path}/repository/repository.php.tpl",
            "dst": "{laravel_path}/app/Repositories/",
            "filename": "{uclassname}Repository.php"
        },

        {
            "name": "seeding",
            "src": "{template_path}/seed.php.tpl",
            "dst": "{laravel_path}/{seed_path}",
            "filename": "{name}_seed.php"
        },
        {
            "name": "migration",
            "src": "{template_path}/migration/migration.php.tpl",
            "dst": "{laravel_path}/{migration_path}",
            "filename": "{filetime}_create_{name}_table.php"
        }                          
    ],
    "main": [
        {
            "name": "routes",
            "src": "{template_path}/routes/routes.all.php.tpl",
            "dst": "{laravel_path}/{route_path}",
            "filename": "web.php"
        },
        {
            "name": "seedmain",
            "src": "{template_path}/seeder.php.tpl",
            "dst": "{laravel_path}/{seed_path}",
            "filename": "DatabaseSeeder.php"
        },
        {
            "name": "main_layout",
            "src": "{template_path}/view.main.layout.php.tpl",
            "dst": "{laravel_path}/{view_path}",
            "filename": "main_layout.blade.php"
        },
        {
            "name": "listhelper",
            "src": "{template_path}/helper.list.php.tpl",
            "dst": "{laravel_path}/app/Helpers/",
            "filename": "ListHelper.php"
        }            
    ]
}