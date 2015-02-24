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

class {{classname}}Controller extends Controller {

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



    $select = ['{{toLowerCase name}}.*',{{#each relation_array.belongsTo}}
    {{~#each this.column~}}
    '{{../table_name}}.{{this}} as {{../table_class}}_{{this}}',
    {{~/each}}
    {{~/each}}];

    return View('{{toLowerCase classname}}_index', [

        {{#each relation_array.belongsTo}}
        '{{toLowerCase relatedmodel}}_list' => {{relatedmodel}}::lists("{{toLowerCase relatedcolumn}}", "id"),
        {{/each}}

      {{#if relation_array.belongsTo}}
        '{{toLowerCase classname}}' => {{classname~}}
          {{~#each relation_array.belongsTo}}
            

            {{#unless @index~}}::{{else}}->{{/unless}}leftjoin('{{table_name}}', '{{table_name}}.id', '=', '{{toLowerCase ../../name}}.{{toLowerCase relatedmodel}}_id')
          {{~/each}}
            

            ->select($select)

            ->get(),
      {{else}}
        '{{toLowerCase classname}}' => {{classname}}::all(),
      {{/if}}
    ]);
  }

  /**
   * Show the form for creating a new resource.
   *
   * @return Response
   */
  public function create(Request $request)
  {
      {{classname}}::create($request->all());
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

    return View('{{toLowerCase classname}}_show', [

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
    return View('{{toLowerCase classname}}_show', [

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
    return Redirect::route('{{toLowerCase classname}}.index');
  }
  
}

?>