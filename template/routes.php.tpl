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

/**
 * Router for {{name}}
 **/

Route::group(['prefix' => '{{toLowerCase name}}', 'middleware' => ['auth','checkadmin']], function()
{

	//read

	Route::get('/', '{{classname}}Controller@index');
	Route::get('/create', '{{classname}}Controller@create');
	Route::get('/{id}', '{{classname}}Controller@show');
	Route::get('/{id}/edit', '{{classname}}Controller@edit');
	{{#each relation_array.hasMany}}
	Route::get('/{id}/create/{{toLowerCase relatedmodel}}', '{{../classname}}Controller@create{{relatedmodel}}');
	Route::get('/{id}/show/{{toLowerCase relatedmodel}}', '{{../classname}}Controller@show{{relatedmodel}}');

	{{/each}}  


});


Route::group(['prefix' => '{{toLowerCase name}}', 'middleware' => ['auth','checkadmin']], function()
{	

	//update	

	Route::post('/', '{{classname}}Controller@store');
	Route::put('/{id}', '{{classname}}Controller@update');
	Route::patch('/{id}', '{{classname}}Controller@update');
	Route::delete('/delete/{id}', '{{classname}}Controller@destroy');
	Route::get('/delete/{id}', '{{classname}}Controller@destroy');
	{{#each relation_array.hasMany}}
	Route::post('/{id}/create/{{toLowerCase relatedmodel}}', '{{../classname}}Controller@store{{relatedmodel}}');	
	{{/each}}  


});


{{/each}}



Route::group(['middleware' => ['auth','checkadmin']], function()
{
	Route::get('/', 'AccountController@index');
});

/*
|
|	Auth Controllers
|
*/

Route::controllers([
    'auth' => 'Auth\AuthController',
    'password' => 'Auth\PasswordController',
]);
