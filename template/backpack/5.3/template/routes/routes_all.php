<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

{{#each this}}
use App\Models\\{{{MODEL_NAME}}};
{{/each}}  


{{#each this}}

Route::group(['prefix' => 'admin', 'middleware' => 'admin'], function()
{
    CRUD::resource('{{toLowerCase classname }}', 'Admin\\{{ classname }}CrudController');
});

{{/each}}  



{{#each this}}
Route::get('/api/{{toLowerCase classname }}', function()
{
	return {{{MODEL_NAME}}}::all();
});
{{/each}}  



{{#each this}}
{{#ifcond type '===' 'presentation'}}
{{#ifcond category '===' 'map'}}
Route::get('/map/{{toLowerCase classname }}', function()
{
	return "map view";
});
{{/ifcond}}
{{/ifcond}}
{{/each}}  