<?php namespace App\Repositories;

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

	protected $model;
	{{#each relation}}
	protected ${{toLowerCase relatedmodel}};
	{{/each}}

	public function __construct({{classname}} ${{toLowerCase classname}}{{#each relation}},{{relatedmodel}} ${{toLowerCase relatedmodel}}{{/each}})
	{
		$this->model = ${{toLowerCase classname}};
		{{#each relation}}
		$this->{{toLowerCase relatedmodel}} = ${{toLowerCase relatedmodel}};
		{{/each}}		
	}

	public function listAll()
	{
		$this->model->lists('id', 'id');
	}

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
		
	{{#each column}}

	public function findBy{{cameLize name}}(${{name}})
	{
		return $this->model->where('{{name}}', '=', ${{name}})->first();
	}

	{{/each}}

	{{#each relation_array.belongsTo}}

	public function list{{cameLize table_class}}()
	{
		return $this->{{toLowerCase relatedmodel}}->lists('{{relatedcolumn}}', 'id'); 
	}


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
	
	public function find{{cameLize table_name}}()
	{

	}
	
	{{/each}}


}

?>