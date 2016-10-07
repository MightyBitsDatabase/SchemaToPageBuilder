<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Backpack\CRUD\CrudTrait;

class {{{MODEL_NAME}}} extends Model {

  use CrudTrait;

    /*
  |--------------------------------------------------------------------------
  | GLOBAL VARIABLES
  |--------------------------------------------------------------------------
  */

  protected $table = '{{{toLowerCase TABLE_NAME}}}';
  // protected $primaryKey = 'id';
  // protected $guarded = [];
  // protected $hidden = ['id'];
  protected $fillable = [{{{FIELDS}}}];
  public $timestamps = true;

  /*
  |--------------------------------------------------------------------------
  | FUNCTIONS
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | RELATIONS
  |--------------------------------------------------------------------------
  */

  {{#each model.relations}}

  public function {{this.name}}()
  {
    {{#if this.usenamespace}}    
    return $this->{{this.relationtype}}('\\{{this.usenamespace}}\\{{this.relatedmodel}}');
    {{else}}
    return $this->{{this.relationtype}}('\App\\{{this.relatedmodel}}');
    {{/if}}
  }

  {{/each}}

  /*
  |--------------------------------------------------------------------------
  | SCOPES
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | ACCESORS
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | MUTATORS
  |--------------------------------------------------------------------------
  */
}
