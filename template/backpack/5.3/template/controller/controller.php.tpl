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
        {{#ifcond type '!==' 'location'}}
        $this->crud->addColumn('{{{name}}}');
        {{/ifcond}}

        {{~#if fillable}}
        {{#ifcond type '===' 'location'}}
        $this->crud->addColumn('{{{name}}}_latitude');
        $this->crud->addColumn('{{{name}}}_longitude');
        $this->crud->addField([
            'name' => '{{{name}}}_latitude',
            'label' => '{{{name}}}_latitude',
            'attributes' => ['id' => '{{{name}}}_latitude']
        ]);
        $this->crud->addField([
            'name' => '{{{name}}}_longitude',
            'label' => '{{{name}}}_longitude',
            'attributes' => ['id' => '{{{name}}}_longitude']            
        ]);

        $this->crud->addField([
            'name' => '{{{name}}}',
            'label' => '{{{name}}}',
            'type' => 'location-select'            
        ]);

        {{ else }}
        {{#ifcond html_input '===' 'textarea'}}
        $this->crud->addField([
            'name' => '{{{name}}}',
            'label' => '{{{name}}}',
            'type' => 'summernote'            
        ]);
        {{/ifcond}}
        {{#ifcond html_input '===' 'text'}}
        $this->crud->addField([
            'name' => '{{{name}}}',
            'label' => '{{{name}}}',            
        ]);        
        {{/ifcond}}

        {{#ifcond html_input '===' 'file'}}
        $this->crud->addField(
        [   // Upload
            'name' => '{{{name}}}',
            'label' => '{{{name}}}',
            'type' => 'upload',
            'upload' => true,
            'disk' => 'uploads' // if you store files in the /public folder, please ommit this; if you store them in /storage or S3, please specify it;
        ]
        );        
        {{/ifcond}}


        {{#ifcond html_input '===' 'imageupload'}}
        $this->crud->addField([ // image
            'label' => "{{{name}}}",
            'name' => "{{{name}}}",
            'type' => 'image',
            'upload' => true,
            'crop' => true, // set to true to allow cropping, false to disable
            'aspect_ratio' => 1, // ommit or set to 0 to allow any aspect ratio
        ]);
        {{/ifcond}}


        {{/ifcond}}
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
