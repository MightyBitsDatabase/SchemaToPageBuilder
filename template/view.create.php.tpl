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
    Edit
  </div>
  <div class="panel-body">
    <div class="row">
      <div class="col-lg-12">        
        @include("{{toLowerCase classname}}.form_create")
      </div>
    </div>
  </div>
</div>
@stop