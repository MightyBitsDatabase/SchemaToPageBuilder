<?php namespace App\Repositories;

// use App\Repositories\\{{classname}}Repository;

{{#if namespace~}}
    use {{namespace}}\\{{classname}};
{{else~}}
    use App\\{{classname}};
{{/if}}

{{#each relation}}
  {{#if ../../namespace~}}
    use {{namespace}}\\{{relatedmodel}};
  {{else~}}
    use App\\{{relatedmodel}};
  {{/if}}
{{/each}}

/**
* 
*/
class {{classname}}Repository
{

	// Eloquent Model

	protected $model;
	{{#each relation}}
	protected ${{toLowerCase relatedmodel}};
	{{/each}}

	//	Filter

	{{#each column}}
	protected $filter{{cameLize name}};
	{{/each}}




	public function __construct({{classname}} ${{toLowerCase classname}}{{#each relation}},{{relatedmodel}} ${{toLowerCase relatedmodel}}{{/each}})
	{
		$this->model = ${{toLowerCase classname}};
		{{#each relation}}
		$this->{{toLowerCase relatedmodel}} = ${{toLowerCase relatedmodel}};
		{{/each}}

		//set filter to null
		{{#each column}}
		$this->filter{{cameLize name}} = null;
		{{/each}}

	}


	//
	//	get all with related joint
	//

	public function getAll()
	{
      {{#if relation_array.belongsTo}}

	    $select = ['{{toLowerCase name}}.*',{{#each relation_array.belongsTo}}
	    {{~#each this.column~}}
	    '{{../table_name}}.{{this}} as {{../table_class}}_{{this}}',
	    {{~/each}}
	    {{~/each}}];

        return $this->model
          {{~#each relation_array.belongsTo}}
            
           ->leftjoin('{{table_name}}', '{{table_name}}.id', '=', '{{toLowerCase ../../name}}.{{toLowerCase relatedmodel}}_id')
          {{~/each}}
            
           ->select($select)
           ->get();
      {{else}}
        return {{classname}}::all();
      {{/if}}
	}

    public function findAllPaginated($perPage = 9)
    {
        ${{toLowerCase name}} = $this->model->orderBy('id', 'DESC')->paginate($perPage);
        return ${{toLowerCase name}};
    }

	public function find($id)
	{
		return $this->model->find($id);
	}


	public function delete($id)
	{
		$model =  $this->model->findOrFail($id);
		$model->delete();
	}

   	//
	//	find by owned attribute
	//
		
	{{#each column}}

	public function findBy{{cameLize name}}(${{name}})
	{	
		{{#ifcond name '===' 'id'}}
		return $this->model->findOrFail(${{name}});
		{{else}}
		return $this->model->where('{{name}}', '=', ${{name}})->get();
		{{/ifcond}}
	}

	{{/each}}

	//
	//	find by related model attribute
	//

	{{#each relation_array.belongsTo}}

	public function findBy{{cameLize table_class}}{{cameLize relatedcolumn}}(${{relatedcolumn}}, $perPage = 9)
	{
        ${{table_class}} = $this->{{table_class}}->where('{{relatedcolumn}}','=', ${{relatedcolumn}})->first();


        //if (is_null(${{table_class}})) {
            //throw new {{table_class}}NotFoundException('The {{relatedcolumn}} "'.$slug.'" does not exist!');
        //}

        ${{toLowerCase ../name}} = ${{table_class}}->{{toLowerCase ../name}}()->orderBy('id', 'DESC')->paginate($perPage);

        return [ ${{toLowerCase table_class}}, ${{toLowerCase ../name}} ];

	}
	
	{{/each}}
	{{#each relation_array.hasMany}}
	
	//
	//	get has many relation
	//

	public function find{{cameLize table_name}}()
	{

	}
	
	{{/each}}

	//
	//	list for selectbox
	//

	public function listAll()
	{
		$this->model->lists('id', 'id');
	}
	
	{{#each relation_array.belongsTo}}

	public function list{{cameLize table_class}}()
	{
		return $this->{{toLowerCase relatedmodel}}->lists('{{relatedcolumn}}', 'id'); 
	}

	{{/each}}


	//
	//	Filter function
	//

	{{#each column}}

    public function where{{cameLize name}}(${{cameLize name}})
    {
        $this->filter{{cameLize name}} = ${{cameLize name}};
        return $this;
    }

	{{/each}}

	//
	//	Query Builder
	//

    public function getFiltered()
    {
        return $this->getQueryBuilder()->get();
    }
    
    public function getFilteredPaginated($perpage = 20)
    {
        return $this->getQueryBuilder()->paginate($perpage);
    }    

	protected function getQueryBuilder()
    {


        $modelClass = $this->model;
        $builder = $modelClass->newQuery();
    	
    	{{#if relation_array.belongsTo}}
		
	    $select = ['{{toLowerCase name}}.*',{{#each relation_array.belongsTo}}
	    {{~#each this.column~}}
	    '{{../table_name}}.{{this}} as {{../table_class}}_{{this}}',
	    {{~/each}}
	    {{~/each}}];

		$builder{{~#each relation_array.belongsTo~}}
		->leftjoin('{{table_name}}', '{{table_name}}.id', '=', '{{toLowerCase ../../name}}.{{toLowerCase relatedmodel}}_id')
		{{~/each~}}
		->select($select);
		{{/if}}

		$builder->orderBy('id', 'desc');

    	{{#each column}}
        if ($this->filter{{cameLize name}}) {
            $builder->where('{{name}}', $this->filter{{cameLize name}});
        }
    	{{/each}}

    	{{#each column}}
        $this->filter{{cameLize name}} = null;    	
    	{{/each}}

        return $builder;
    }



}

?>