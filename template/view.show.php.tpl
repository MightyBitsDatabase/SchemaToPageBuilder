@extends('main_layout')
@section('content')
<div class="row">
  <div class="col-lg-12">
    <h2 class="page-header">
    {{classname}} <small>Detail View</small>
    </h2>
  </div>
</div>

<div class="row">
  <div class="col-lg-12">
            <table class="table table-bordered table-condensed ">
          <thead>
            <tr>
              {{#each column}}
              <th>{{ucFirst name}}</th>
              {{/each}}
            </tr>
          </thead>
          <tbody>
            <tr>
              {{#each column}}
              
              <td>{!!  ${{toLowerCase ../classname}}->{{name}} !!}</td>
              
              {{/each}}
            </tr>
          </tbody>
        </table>

  </div>
</div>

{{#each relation_array.hasMany}}
<div class="row">
  <div class="col-lg-12">
    <h3 class="">
    {{relatedmodel}} <small>List View</small><a href="\{{ action('{{../classname}}Controller@create{{relatedmodel}}', ${{toLowerCase ../classname}}->id) }}" onClick="lsdModal(this); return false" class="btn btn-primary btn-success pull-right" content-target="{{toLowerCase relatedmodel}}-list" ><span class="pencil"></span> create {{toLowerCase relatedmodel}}</a>
    </h3><hr>
  </div>
  <div class="col-lg-12">
  </div>
  <div id="{{toLowerCase relatedmodel}}-list" content-url="\{{ action('{{../classname}}Controller@show{{relatedmodel}}', ${{toLowerCase ../classname}}->id) }}"  class="col-lg-12">
    @include('{{toLowerCase relatedmodel}}.list', ['{{toLowerCase relatedmodel}}' => ${{toLowerCase relatedmodel}}])
  </div>
</div>
{{/each}}
@stop