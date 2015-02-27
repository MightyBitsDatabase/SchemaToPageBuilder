@extends('main_layout')
@section('content')
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">
    {{classname}} <small>List View</small>
    </h1>
  </div>
  <div class="col-lg-12">
    <div class="table-responsive">
      <table class="table table-bordered table-condensed table-hover table-striped">
        <thead>
          <tr>
               {{#each column}}
               {{#ifcond name '!==' 'id'}}
            <th>{{ucFirst name}}</th>
               {{/ifcond}}
               {{/each}}
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          @foreach (${{toLowerCase classname}} as $row)
          <tr>
               {{#each column}}
               {{#ifcond name '!==' 'id'}}
            {{#if relation}}
            <td>\{{ $row->{{toLowerCase relation.name}}_{{relation.relatedcolumn}} }}</td>
            {{else}}
            <td>\{{ $row->{{name}} }}</td>
            {{/if}}
               {{/ifcond}}
               {{/each}}
            <td><a href="\{{ action('{{classname}}Controller@show', $row->id) }}" class="btn btn-xs btn-default">detail</a> <a href="\{{ action('{{classname}}Controller@edit', $row->id) }}" class="btn btn-xs btn-default">edit</a> 

            <a href="\{{ action('{{classname}}Controller@destroy', $row->id) }}" class="btn btn-xs btn-default">delete</a></td>
          </tr>
          @endforeach
        </tbody>
      </table>
    </div>
  </div>
</div>
@stop