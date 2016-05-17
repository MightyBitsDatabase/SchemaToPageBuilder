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

use App\Http\Requests\\{{classname}}Request;


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
  public function index(Request $request)
  {

    $perpage = $request->perpage;

    if (is_null($perpage))
    {
      $perpage = 25;
    }

    ${{toLowerCase classname}} = $this->{{classname}}Repo->getFilteredPaginated($perpage);
    ${{toLowerCase classname}}->appends(['perpage' =>  $perpage]);


    if ($request->ajax()) {
      return View('{{toLowerCase classname}}.table', compact('{{toLowerCase classname}}'));
    }

      return View('{{toLowerCase classname}}.index', compact('{{toLowerCase classname}}'));
  
  }


  /**
   * Show the form for creating a new resource.
   *
   * @return Response
   */
  public function create(Request $request)
  {

      if ($request->ajax()) {
        return View('{{toLowerCase classname}}.form_create')->withModal(true)->with('modalTitle', 'Create {{ classname }}');
      }

      return View('{{toLowerCase classname}}.create');        
  }


  /**
   * Store a newly created resource in storage.
   *
   * @return Response
   */
  public function store(Request $request)
  {


    $current_user = $this->getCurrentUser();


    if ($current_user['role'] == 'Admin')
    { 
      $request_new = $request->all();
    }else{
      $request_new = $request->all();
      $request_new['user_id'] = $current_user['id'];
    }


    {{#each column}}
    {{#ifcond uploadfile '===' true}}
    //todo refactor this
    ${{ucFirst name }}File = $request_new['{{name}}'];
    $filename =  pathinfo(${{ucFirst name }}File->getClientOriginalName(), PATHINFO_FILENAME).'-'.uniqid().'.'.${{ucFirst name }}File->getClientOriginalExtension();
    ${{ucFirst name }}File->move( public_path("uploads/posts") , $filename );
    $request_new['{{ name }}'] = $filename;
    {{/ifcond}}
    {{/each}}


    {{classname}}::create($request_new);


    if ($request->ajax()) return [ 'success'  => true ];

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
    
    ${{toLowerCase classname}} = {{classname}}::findOrFail($id);

    {{#each relation_array.hasMany}}
    ${{toLowerCase relatedmodel}} = $this->{{relatedmodel}}Repo->where{{ucFirst ../classname}}Id($id)->getFiltered();
    {{/each}}

    return View('{{toLowerCase classname}}.show', compact('{{toLowerCase classname}}' {{#each relation_array.hasMany}},'{{toLowerCase relatedmodel}}'{{/each}}));

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
  public function edit($id, Request $request)
  {

   $hidden = $this->mergeHiddenField(['{{toLowerCase classname}}_id' => true]);
   $action_url   =  $request->url();

   ${{toLowerCase classname}} = $this->{{classname}}Repo->findById($id);
   {{#each relation_array.hasMany}}
   ${{toLowerCase relatedmodel}} = $this->{{relatedmodel}}Repo->where{{ucFirst ../classname}}Id($id)->getFiltered();
   {{/each}}   

    //return "create a new {{relatedmodel}} that belongs to {{../classname}} " . $id;
    if ($request->ajax()) {
        return View('{{toLowerCase classname}}.form_edit', compact('action_url', 'hidden', '{{toLowerCase classname}}'{{#each relation_array.hasMany}}, '{{toLowerCase relatedmodel}}'{{/each}}))->withModal(true)->with('modalTitle', 'Edit {{ classname }}');
    }
  
    return View('{{toLowerCase classname}}.edit', compact('action_url', 'hidden', '{{toLowerCase classname}}'{{#each relation_array.hasMany}}, '{{toLowerCase relatedmodel}}'{{/each}}));      
    

  }



  /**
   * Update the specified resource in storage.
   *
   * @param  int  $id
   * @return Response
   */
  public function update($id, Request $request)
  {

      $resource = $this->{{classname}}Repo->findById($id);

      if($this->checkUserCanEdit($resource))
      {
        $resource->update($request->all());
      }else{

        if($request->ajax()) return ['success' => 'false'];

        return redirect('{{toLowerCase name}}');        

      }


    if($request->ajax()) return ['success' => 'true'];


    return redirect('{{toLowerCase name}}');

  }


  /**
   * Remove the specified resource from storage.
   *
   * @param  int  $id
   * @return Response
   */
  public function destroy($id, Request $request)
  {

    $resource = $this->{{classname}}Repo->findById($id);

    if ($this->checkUserCanDelete($resource)) {
        $this->{{classname}}Repo->delete($id);
    }else{

      if($request->ajax()) return ['success' => 'false'];
      return Redirect::back();

    }
    
    if($request->ajax()) return ['success' => 'true'];

    return Redirect::back();

  }


{{#each relation_array.hasMany}}
  /**
   * Show the form for creating a new {{relatedmodel}} that owned by {{../classname}}
   *
   * @return Response
   */

  public function create{{relatedmodel}}($id, Request $request)
  {


    $hidden = $this->mergeHiddenField(['{{toLowerCase ../classname}}_id' => true]);
    $action_url =  $request->url();

    if ($request->ajax()) {
        return View('{{toLowerCase relatedmodel}}.form_create', compact('action_url', 'hidden') )->withModal(true)->with('modalTitle', 'Create {{relatedmodel}}');
    }
    
    return View('{{toLowerCase relatedmodel}}.create', compact('action_url', 'hidden')  );        
      
  }


  public function show{{relatedmodel}}(${{toLowerCase ../classname}}_id, Request $request)
  {

    ${{toLowerCase relatedmodel}} = $this->{{relatedmodel}}Repo->where{{ucFirst ../classname}}Id(${{toLowerCase ../classname}}_id)->getFiltered();

    return View('{{toLowerCase relatedmodel}}.list', compact('{{toLowerCase  relatedmodel}}') );

  }


  public function store{{relatedmodel}}(${{toLowerCase ../classname}}_id, Request $request)
  {

    $resource = {{../classname}}::findOrFail(${{toLowerCase ../classname}}_id);

    $request_new = $request->all();

    if ($this->checkUserCanEdit($resource {{#contains column "user_id"}}, 'id'{{/contains}}))
    {
      
      $request_new['{{toLowerCase ../classname}}_id'] = $resource->id;
      

      {{#each column_full}}
      {{#ifcond uploadfile '===' true}}
      //todo refactor this
      ${{ucFirst name }}File = $request_new['{{name}}'];
      $filename =  pathinfo(${{ucFirst name }}File->getClientOriginalName(), PATHINFO_FILENAME).'-'.uniqid().'.'.${{ucFirst name }}File->getClientOriginalExtension();
      ${{ucFirst name }}File->move( public_path("uploads/posts") , $filename );
      $request_new['{{ name }}'] = $filename;
      {{/ifcond}}
      {{/each}}

      ${{toLowerCase ../classname}}_new = new {{relatedmodel}}($request_new);
      ${{toLowerCase ../classname}}_new->save();

    }else{
      
      if ($request->ajax()) return [ 'success'  => false ]; 
      
      return redirect('{{toLowerCase name}}');
    
    }

    if ($request->ajax()) return [ 'success'  => true ];

    return redirect('{{toLowerCase name}}');


  }

  //todo...
  public function delete{{relatedmodel}}(${{toLowerCase relatedmodel}}_id, ${{toLowerCase ../classname}}_id, Request $request)
  {


  }


{{/each}}


// !todo! refactor this on template


  private function getCurrentUser()
  {
    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;
    
    return array('role' => $auth_user_role, 'id' => $auth_user_id);
  }

  //hide field

  private function mergeHiddenField($hidden_field)
  {

    $shared_hidden = view()->shared('hidden');

    if (is_array($shared_hidden))
    {
      $hidden_field = array_merge($hidden_field, $shared_hidden);      
    }

    return $hidden_field;
  }

  private function checkUserCanDelete($resource, $fk = 'user_id')
  {

    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;

    if ( $auth_user_role == 'Admin') return true;

    if (is_null($resource[$fk])) return false;

    if ($resource[$fk] ==  $auth_user_id ) {
      return true;
    }else{
      return false;
    }


  }


  private function checkUserCanEdit($resource, $fk = 'user_id')
  {

    if (is_null($resource[$fk])) return true;

    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;


    if ( $auth_user_role == 'Admin')
    { 
        return true;
    }else{
      if ($resource[$fk] == $auth_user_id ) {
        return true;
      }else{
        return false;
      }
    }

  }
  
}

?>