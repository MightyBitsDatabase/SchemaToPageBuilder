<?php

namespace App\Models;

use Eloquent as Model;


class BlogUser extends Model
{

    public $table = 'BlogUsers';
    


    public $fillable = [
    	'username',	
	'password',	
	'profile'
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
    	'id' => 'increments',
	'username' => 'string',
	'password' => 'string',
	'profile' => 'text'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        
    ];

    

  public function posts()
  {
    return $this->hasMany('\App\Post');
  }

}
