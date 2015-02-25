<?php 

{{#if namespace}}
namespace {{namespace}};
{{else}}
namespace App;
{{/if}}

use Illuminate\Database\Eloquent\Model;

{{#if softdelete}}
use SoftDeletingTrait;
{{/if}}

class {{classname}} extends Model {

  {{#if model.fillable}}
  protected $fillable = array({{{csv model.fillable}}});
  {{/if}}
  {{#if model.guarded}}
  protected $guarded = array({{{csv model.guarded}}});
  {{/if}}
  {{#if model.visible}}
  protected $visible = array({{{csv model.visible}}});
  {{/if}}
  {{#if model.hidden}}
  protected $hidden = array({{{csv model.hidden}}});
  {{/if}}

  protected $table = '{{toLowerCase name}}';
  
  {{#if timestamp}}
  public $timestamps = true;
  {{else}}
  public $timestamps = false;
  {{/if}}

  {{#each column}}

  public function {{this.name}}()
  {
    return $this->{{this.name}};
  }

  {{/each}}

  //
  //relation
  //
  
  {{#each model.relations}}

  public function {{this.name}}()
  {
    {{#if this.usenamespace}}    
    return $this->{{this.relationtype}}('\{{this.usenamespace}}\\{{this.relatedmodel}}');
    {{else}}
    return $this->{{this.relationtype}}('\App\\{{this.relatedmodel}}');
    {{/if}}
  }

  {{/each}}

}


