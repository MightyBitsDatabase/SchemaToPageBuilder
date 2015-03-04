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

    ${{classname}} = $this->{{classname}}Repo;

    $paginated = ${{classname}}->getFilteredPaginated($perpage);
    $paginated->appends(['perpage' =>  $perpage]);


    if ($request->ajax()) {
      return View('{{toLowerCase classname}}_table', [
          '{{toLowerCase classname}}' => $paginated
      ]);
    }else{
      return View('{{toLowerCase classname}}_index', [
          '{{toLowerCase classname}}' => $paginated
      ]);
    }



  }


  /**
   * Show the form for creating a new resource.
   *
   * @return Response
   */
  public function create(Request $request)
  {

      if ($request->ajax()) {
        return View('{{toLowerCase classname}}_form_create', ['modal' => true]);
      }else{
        return View('{{toLowerCase classname}}_create');        
      }
  }


  /**
   * Store a newly created resource in storage.
   *
   * @return Response
   */
  public function store(Request $request)
  {


    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;


    if ($auth_user_role == 'Admin')
    { 
      $request_new = $request->all();
    }else{
      $request_new = $request->all();
      $request_new['user_id'] = $auth_user_id;
    }

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
    
    {{#each relation_array.hasMany}}
    ${{relatedmodel}} = $this->{{relatedmodel}}Repo;
    ${{relatedmodel}}->where{{ucFirst ../classname}}Id($id);

    {{/each}}

    return View('{{toLowerCase classname}}_show', [

      '{{toLowerCase classname}}' => {{classname}}::findOrFail($id),
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
  public function edit($id, Request $request)
  {

    {{#each relation_array.hasMany}}
    ${{relatedmodel}} = $this->{{relatedmodel}}Repo;
    ${{relatedmodel}}->where{{ucFirst ../classname}}Id($id);
    {{/each}}


    $hidden_field = ['{{toLowerCase classname}}_id' => true];

    $shared_hidden = view()->shared('hidden');

    if (is_array($shared_hidden))
    {
      $hidden_field = array_merge($hidden_field, $shared_hidden);      
    }

    $action_url =  $request->url();

    //return "create a new {{relatedmodel}} that belongs to {{../classname}} " . $id;
    if ($request->ajax()) {
        return View('{{toLowerCase classname}}_form_edit', [
          'modal' => true,
          'action_url' => $action_url, 
          'hidden' => $hidden_field,
          '{{toLowerCase classname}}' => $this->{{classname}}Repo->findById($id),

          {{#each relation_array.hasMany}}
            '{{toLowerCase relatedmodel}}' => ${{relatedmodel}}->getFiltered(),
          {{/each}}     
        ]);
    }else{
        return View('{{toLowerCase classname}}_edit', [
          'action_url' => $action_url, 
          'hidden' => $hidden_field,
          '{{toLowerCase classname}}' => $this->{{classname}}Repo->findById($id),

          {{#each relation_array.hasMany}}
            '{{toLowerCase relatedmodel}}' => ${{relatedmodel}}->getFiltered(),
          {{/each}}     

        ]);        
    }  

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

    if ($this->checkUserCanEdit($resource)) {
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



    $hidden_field = ['{{toLowerCase ../classname}}_id' => true];


    $shared_hidden = view()->shared('hidden');

    if (is_array($shared_hidden))
    {
      $hidden_field = array_merge($hidden_field, $shared_hidden);      
    }


    $action_url =  $request->url();

    //return "create a new {{relatedmodel}} that belongs to {{../classname}} " . $id;
    if ($request->ajax()) {
        return View('{{toLowerCase relatedmodel}}_form_create', ['modal' => true,'action_url' => $action_url, 'hidden' => $hidden_field]);
    }else{
        return View('{{toLowerCase relatedmodel}}_create', ['action_url' => $action_url, 'hidden' => $hidden_field]);        
    }  
  }

  public function store{{relatedmodel}}(${{toLowerCase ../classname}}_id, Request $request)
  {

    $resource = {{../classname}}::findOrFail(${{toLowerCase ../classname}}_id);

    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;    

    $request_new = $request->all();

    if ($this->checkUserCanEdit($resource))
    {
      
      {{#contains column "user_id"}}
      $request_new['user_id'] = $auth_user_id;
      {{/contains}}
      $request_new['{{toLowerCase ../classname}}_id'] = $resource->id;
      
      ${{toLowerCase ../classname}}_new = new {{relatedmodel}}($request_new);
      ${{toLowerCase ../classname}}_new->save();

    }else{
      if ($request->ajax()) return [ 'success'  => false ]; 
      return Redirect::back();
    }

    if ($request->ajax()) return [ 'success'  => true ];    
    return Redirect::back();


  }

{{/each}}

  private function checkUserCanEdit($resource)
  {

    if (is_null($resource->user_id)) return true;

    $auth_user = \Auth::User();
    $auth_user_role = $auth_user->role->name;
    $auth_user_id = $auth_user->id;


    if ( $auth_user_role == 'Admin')
    { 
        return true;
    }else{
      if ($resource->user_id == $auth_user_id ) {
        return true;
      }else{
        return false;
      }
    }

  }
  
}

?>