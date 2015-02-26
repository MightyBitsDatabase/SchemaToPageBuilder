<?php namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Request;

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

use App\Repositories\\{{classname}}Repository;

{{#each relation_array.hasMany~}}
    use App\Repositories\\{{relatedmodel}}Repository;
{{/each}}


class {{classname}}Controller extends Controller {

protected ${{classname}}Repo;
{{#each relation_array.hasMany}}
protected ${{relatedmodel}}Repo;
{{/each}}


  public function __construct({{classname}}Repository ${{classname}}{{#each relation_array.hasMany~}},{{relatedmodel}}Repository ${{relatedmodel}}{{/each}})
  {

    $this->{{classname}}Repo = ${{classname}};
    {{#each relation_array.hasMany}}
    $this->{{relatedmodel}}Repo = ${{relatedmodel}};
    {{/each}}


  }


  /**
   * Display a listing of the resource.
   *
   * @return Response
   *
   *  Route::get('{{toLowerCase classname}}', '{{classname}}Controller@index');
   * 
   */
  public function index()
  {

    ${{classname}} = $this->{{classname}}Repo;

    return View('{{toLowerCase classname}}_index', [

        {{#each relation_array.belongsTo}}
        '{{toLowerCase relatedmodel}}_list' => {{relatedmodel}}::lists("{{toLowerCase relatedcolumn}}", "id"),
        {{/each}}
        '{{toLowerCase classname}}' => ${{classname}}->getFiltered()
    ]);
  }

  /**
   * Show the form for creating a new resource.
   *
   * @return Response
   */
  public function create(Request $request)
  {
      return View('{{toLowerCase classname}}_create', [

      {{#each relation_array.belongsTo}}
      '{{toLowerCase relatedmodel}}' => {{relatedmodel}}::lists("{{toLowerCase relatedcolumn}}", "id"),
      {{/each}}
      
      ]);

  }

  /**
   * Store a newly created resource in storage.
   *
   * @return Response
   */
  public function store(Request $request)
  {
    {{classname}}::create($request->all());
    return Redirect::back();
  }

  /**
   * Display the specified resource.
   *
   * @param  int  $id
   * @return Response
   *
   *  Route::get('{{toLowerCase classname}}/{id}', '{{classname}}Controller@show');
   * 
   */
  public function show($id)
  {
    //  todo relationship
    //
    
    {{#each relation_array.hasMany}}
    ${{relatedmodel}} = $this->{{relatedmodel}}Repo;
    ${{relatedmodel}}->where{{ucFirst ../classname}}Id($id);

    {{/each}}

    return View('{{toLowerCase classname}}_show', [

      '{{toLowerCase classname}}' => {{classname}}::findOrFail($id),
    {{#each relation_array.belongsTo}}
      '{{toLowerCase relatedmodel}}' => {{relatedmodel}}::lists("{{toLowerCase relatedcolumn}}", "id"),
    {{/each}}
    {{#each relation_array.hasMany}}
      '{{toLowerCase relatedmodel}}' => ${{relatedmodel}}->getFiltered(),
    {{/each}}    
    
    ]);


  }

  /**
   * Show the form for editing the specified resource.
   *
   * @param  int  $id
   * @return Response
   *
   *  Route::get('{{toLowerCase classname}}/{id}', '{{classname}}Controller@edit');
   * 
   */
  public function edit($id)
  {
    return View('{{toLowerCase classname}}_edit', [

      '{{toLowerCase classname}}' => {{classname}}::findOrFail($id),
    {{#each relation_array.belongsTo}}
      '{{toLowerCase relatedmodel}}' => {{relatedmodel}}::lists("{{toLowerCase relatedcolumn}}", "id"),
    {{/each}}
    {{#each relation_array.hasMany}}
      '{{toLowerCase relatedmodel}}' => {{relatedmodel}}::where("{{toLowerCase ../classname}}_id", $id)->get(),
    {{/each}}     
    
    ]);

  }

  /**
   * Update the specified resource in storage.
   *
   * @param  int  $id
   * @return Response
   */
  public function update($id, Request $request)
  {
    ${{toLowerCase classname}} = {{classname}}::findOrFail($id);
    ${{toLowerCase classname}}->update($request->all());
    return redirect('{{toLowerCase name}}');
  }

  /**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return Response
   */
  public function destroy($id)
  {
    ({{classname}}::destroy($id));
    return Redirect::back();
  }
  
}

?>