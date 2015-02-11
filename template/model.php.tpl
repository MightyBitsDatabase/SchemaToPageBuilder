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

class {{model.classname}} extends Model {

  {{#if fillable}}
  protected $fillable = array({{{csv fillable}}});
  {{/if}}
  {{#if guarded}}
  protected $guarded = array({{{csv guarded}}});
  {{/if}}
  {{#if visible}}
  protected $visible = array({{{csv visible}}});
  {{/if}}
  {{#if hidden}}
  protected $hidden = array({{{csv hidden}}});
  {{/if}}

  protected $table = '{{toLowerCase model.name}}';
  
  {{#if model.timestamp}}
  public $timestamps = true;
  {{else}}
  public $timestamps = false;
  {{/if}}

  {{#each model.column}}

  public function {{this.name}}()
  {
    return $this->{{this.name}};
  }

  {{/each}}

  //
  //relation
  //
  
  {{#each relations}}

  public function {{this.name}}()
  {
    return $this->{{this.relationtype}}('{{this.relatedmodel}}');
  }

  {{/each}}

}


