{
    "path": {
        "template_path": "/template",
        "laravel_path": "",
        "view_path": "resources/views",
        "model_path": "app/Models",
        "controller_path": "/app/Http/Controllers",
        "route_path": "routes",
        "migration_path": "database/migrations",
        "seed_path": "seeds"
    },
    "fields": {    
            "menu_template": {
            "src": "{template_path}/layouts/menu_template.blade.php",
            "dst": "{laravel_path}/{view_path}",
            "filename" : "{uclassname}.menu_template.blade.php"
        }                    
    },
    "routes": {
            "src": "{template_path}/routes/routes.php.tpl",
            "dst": "{laravel_path}/{route_path}",
            "filename": "temp_web.php"
    },
    "table": [
        {
            "name": "request_create",
            "src": "{template_path}/request/create_request.php.tpl",
            "dst": "{laravel_path}//app/Http/Requests/",
            "filename": "Store{uclassname}Request.php"
        },    
        {
            "name": "request_update",
            "src": "{template_path}/request/update_request.php.tpl",
            "dst": "{laravel_path}//app/Http/Requests/",
            "filename": "Update{uclassname}Request.php"
        },    
        {
            "name": "model",
            "src": "{template_path}/model/model.php.tpl",
            "dst": "{laravel_path}/{model_path}",
            "filename": "{uclassname}.php"
        },
        {
            "name": "controller",
            "src": "{template_path}/controller/controller.php.tpl",
            "dst": "{laravel_path}/{controller_path}/Admin",
            "filename": "{uclassname}CrudController.php"
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
            "name" : "menu",
            "src": "{template_path}/layouts/menu.blade.php",
            "dst": "{view_path}/layouts",
            "filename" : "menu.blade.php"
        },
        {
            "name" : "routes",
            "src": "{template_path}/routes/routes_all.php",
            "dst": "{laravel_path}/routes",
            "filename" : "web.php"
        }                
    ]
}