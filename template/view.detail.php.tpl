@extends('main_layout')
@section('content')
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">
    {{classname}} <small>Detail View</small>
    </h1>
  </div>
</div>
<div class="panel panel-default">
  <div class="panel-heading">
    Edit
  </div>
  <div class="panel-body">
    <div class="row">
      <div class="col-lg-12">
        {!! Form::model( ${{toLowerCase classname}}, ['action' => ['{{classname}}Controller@edit', ${{toLowerCase classname}}->id], 'method' => 'post'] ) !!}
        
        {{#each column}}

       {{#if relation}}
        <div class="form-group">
          <label for="{{relatedmodel}}_{{relatedcolumn}}">{{relation.relatedmodel}} {{ucFirst relation.relatedcolumn}}</label>
          {!! Form::select('{{toLowerCase relation.relatedmodel}}_id', ${{toLowerCase relation.relatedmodel}},  ${{toLowerCase ../../classname}}->{{toLowerCase relation.relatedmodel}}_id, ['class' => 'form-control']) !!}
        </div>
       {{else}}
        <div class="form-group">
          <label for="{{name}}">{{ucFirst name}}</label>
          {!! Form::text('{{name}}', null, ['class' => 'form-control']) !!}
        </div>
       {{/if}}



        {{/each}}

        <div class="form-group">
          {!! Form::submit('Update {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
          {!! Form::submit('Delete {{ucFirst classname}}', ['class' => 'btn btn-danger']) !!}
        </div>
        {!! Form::close() !!}
      </div>
    </div>
  </div>
</div>
{{#each relation_array.hasMany}}
<div class="row">
  <div class="col-lg-12">
    <h2 class="">
    {{relatedmodel}} <small>List View</small>
    </h2>
  </div>
  <div class="col-lg-12">
    @include('{{toLowerCase relatedmodel}}_list', ['{{toLowerCase relatedmodel}}' => ${{toLowerCase relatedmodel}}])
  </div>
</div>
{{/each}}
@stop