<?php namespace App\Http\Controllers\Admin;

use Backpack\CRUD\app\Http\Controllers\CrudController;

// VALIDATION: change the requests to match your own file names if you need form validation
use {{{NAMESPACE_REQUEST}}}\Store{{{MODEL_NAME}}}Request as StoreRequest;
use {{{NAMESPACE_REQUEST}}}\Update{{{MODEL_NAME}}}Request as UpdateRequest;

class {{{MODEL_NAME}}}CrudController extends CrudController {

  public function __construct() {
        parent::__construct();

        $this->crud->setModel("App\Models\\{{{MODEL_NAME}}}");
        $this->crud->setRoute("admin/{{{toLowerCase MODEL_NAME}}}");
    
        $this->crud->setEntityNameStrings('{{{MODEL_NAME}}}', '{{{MODEL_NAME}}}');

        {{#each column}}
        $this->crud->addColumn('{{{name}}}');

        {{~#if fillable}}

        $this->crud->addField([
            'name' => '{{{name}}}',
            'label' => '{{{name}}}',            
        ]);
        {{/if}}    
        {{/each}}
    }

  public function store(StoreRequest $request)
  {
    return parent::storeCrud();
  }

  public function update(UpdateRequest $request)
  {
    return parent::updateCrud();
  }
}
