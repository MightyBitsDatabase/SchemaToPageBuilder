@extends('main_layout')
@section('content')
<div class="row">
  <div class="col-lg-12">
    <h2 class="page-header">
    {{classname}} <small>Detail View</small>
    </h2>
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
    <h3 class="">
    {{relatedmodel}} <small>List View</small><a href="\{{ action('{{../classname}}Controller@create{{relatedmodel}}', ${{toLowerCase ../classname}}->id) }}" onClick="lsdModal(this); return false" class="btn btn-primary btn-success pull-right" content-target="{{toLowerCase relatedmodel}}-list" ><span class="pencil"></span> create {{toLowerCase relatedmodel}}</a>

    </h3><hr>
  </div>

  <div class="col-lg-12 alert">
  </div>

  <div id="{{toLowerCase relatedmodel}}-list" content-url="{{ action('{{../classname}}Controller@show{{relatedmodel}}', ${{toLowerCase ../classname}}->id) }}"  class="col-lg-12">
    @include('{{toLowerCase relatedmodel}}_list', ['{{toLowerCase relatedmodel}}' => ${{toLowerCase relatedmodel}}])
  </div>
</div>
{{/each}}
@stop