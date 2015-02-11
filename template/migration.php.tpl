<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Create{{ucFirst name}}Table extends Migration {

  /**
   * Run the migrations.
   *
   * @return void
   */
  public function up()
  {
    Schema::create('{{{toLowerCase name}}}', function(Blueprint $table) {

      {{#each column}}
        {{#ifc length "" ~}}$table->{{{type}}}('{{{name}}}'){{else}}$table->{{{type}}}('{{{name}}}', {{{length}}}){{~/ifc ~}}
        {{~ife ai "->increments()"}}            
        {{~ife pk "->primary()"}}      
        {{~ife nu "->nullable()"}}
        {{~ife ui "->unsigned()"}}
        {{~ife in "->index()"}}
        {{~ife un "->unique()"}}        
        {{~#if defaultvalue}}->default("{{defaultvalue}}"){{/if}};
        {{/each}}
      {{~#if timestamp}}
        $table->timestamps();
      {{/if}}
      
    });
  }

  /**
   * Reverse the migrations.
   *
   * @return void
   */
  public function down()
  {
    Schema::drop('{{{toLowerCase name}}}');
  }
}