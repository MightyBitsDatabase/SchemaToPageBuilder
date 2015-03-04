@extends('main_layout')
@section('content')
<div class="row">
	<div class="col-lg-12">
		<h2 class="page-header">
		{{classname}} <small>List View</small>
		<a href="\{{ action('{{classname}}Controller@create') }}" content-target="Table{{classname}}" onClick="lsdModal(this); return false;" class="btn btn-primary btn-success pull-right"><span class="pencil"></span> create {{toLowerCase classname}}</a>
		</h2>
	</div>
	
	<div class="col-lg-12">
	</div>
	<div class="col-lg-12">
		<div class="alert-box">
		</div>
		<div id="Table{{classname}}" content-url="\{{ action('{{classname}}Controller@index')}}" >
			@include("{{toLowerCase classname}}_table")

		</div>
	</div>
</div>
@stop