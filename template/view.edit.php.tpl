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
        @include("{{toLowerCase classname}}.form_edit")
      </div>
    </div>
    {{#each relation_array.hasMany}}
<div class="row">
  <div class="col-lg-12">
    <h2 class="">
    {{relatedmodel}} <small>List View</small>
    <a href="\{{ action('{{relatedmodel}}Controller@create') }}" class="btn btn-primary btn-success pull-right"><span class="pencil"></span> create {{toLowerCase relatedmodel}}</a>
    
    </h2>
  </div>
  <div class="col-lg-12">
    @include('{{toLowerCase relatedmodel}}.list', ['{{toLowerCase relatedmodel}}' => ${{toLowerCase relatedmodel}}])
  </div>
</div>
{{/each}}
  </div>
</div>
@stop