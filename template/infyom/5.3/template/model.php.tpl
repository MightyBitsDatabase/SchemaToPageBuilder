<?php

namespace {{{NAMESPACE_MODEL}}};

use {{{NAMESPACE_MODEL_EXTEND}}} as Model;
{{{SOFT_DELETE_IMPORT}}}
{{{DOCS}}}
class {{{MODEL_NAME}}} extends Model
{
{{{SOFT_DELETE}}}
    public $table = '{{{TABLE_NAME}}}';
    {{{TIMESTAMPS}}}
{{{SOFT_DELETE_DATES}}}
{{{PRIMARY}}}
    public $fillable = [
    {{{FIELDS}}}
    ];

    /**
     * The attributes that should be casted to native types.
     *
     * @var array
     */
    protected $casts = [
    {{{CAST}}}
    ];

    /**
     * Validation rules
     *
     * @var array
     */
    public static $rules = [
        {{{RULES}}}
    ];

    
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
}
