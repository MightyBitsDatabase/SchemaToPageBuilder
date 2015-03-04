{!! Form::model( ${{toLowerCase classname}}, ['action' => [ isset($action) ? $action : '{{classname}}Controller@update', ${{toLowerCase classname}}->id], 'method' => 'patch'] ) !!}

@if(isset($modal))
	@include("{{toLowerCase classname}}_modal")
@else
	@include("{{toLowerCase classname}}_form_partial")
    @yield('modal-body')
    @yield('modal-footer')	
@endif


{!! Form::close() !!}