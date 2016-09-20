<?php

namespace App\Models;

use Eloquent as Model;


class Post extends Model
{

    public $table = 'Posts';
    


    public $fillable = [
    
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
    	'id' => 'increments',
	'title' => 'string',
	'content' => 'text',
	'blogusers_id' => 'integer'
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        
    ];

    

  public function blogusers()
  {
    return $this->belongsTo('\App\BlogUser');
  }

}
