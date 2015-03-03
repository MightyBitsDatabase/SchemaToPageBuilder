@extends('main_layout')
@section('content')
<div class="row">
  <div class="col-lg-12">
    <h1 class="page-header">
    {{classname}} <small>List View</small> 

<a href="\{{ action('{{classname}}Controller@create') }}" onClick="lsdModal(this); return false;" class="btn btn-primary btn-success pull-right"><span class="pencil"></span> create {{toLowerCase classname}}</a>

    </h1>    

  </div>
  <div id="Table{{classname}}" class="col-lg-12">
    @include("{{toLowerCase classname}}_table")
  </div>
</div>
@stop