
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
Route::post('{{toLowerCase name}}', '{{classname}}Controller@store');
Route::get('{{toLowerCase name}}/{id}', '{{classname}}Controller@show');
Route::get('{{toLowerCase name}}/edit/{id}', '{{classname}}Controller@edit');
Route::post('{{toLowerCase name}}/edit/{id}', '{{classname}}Controller@update');

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
