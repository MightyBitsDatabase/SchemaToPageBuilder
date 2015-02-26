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
    Detail
  </div>
  <div class="panel-body">
    <div class="row">
      <div class="col-lg-12">

        
        {{#each column}}

{!!  ${{toLowerCase ../classname}}->{{name}} !!}


        {{/each}}

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