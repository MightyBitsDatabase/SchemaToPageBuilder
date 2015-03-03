
<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

{{#each this}}
Route::get('{{toLowerCase name}}', '{{classname}}Controller@index');
Route::get('{{toLowerCase name}}/create', '{{classname}}Controller@create');
Route::post('{{toLowerCase name}}', '{{classname}}Controller@store');
Route::get('{{toLowerCase name}}/{id}', '{{classname}}Controller@show');
Route::get('{{toLowerCase name}}/{id}/edit', '{{classname}}Controller@edit');
Route::put('{{toLowerCase name}}/{id}', '{{classname}}Controller@update');
Route::patch('{{toLowerCase name}}/{id}', '{{classname}}Controller@update');
Route::delete('{{toLowerCase name}}/delete/{id}', '{{classname}}Controller@destroy');
Route::get('{{toLowerCase name}}/delete/{id}', '{{classname}}Controller@destroy');
{{#each relation_array.hasMany}}
Route::get('{{toLowerCase ../name}}/{id}/create/{{toLowerCase relatedmodel}}', '{{../classname}}Controller@create{{relatedmodel}}');
{{/each}}  




{{/each}}

/*
|
|	Auth Controllers
|
*/

Route::controllers([
    'auth' => 'Auth\AuthController',
    'password' => 'Auth\PasswordController',
]);
