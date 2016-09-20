@if(isset($action_url))
{!! Form::open(['url' => $action_url, 'method' => 'post'] ) !!}
@else
{!! Form::open(['action' => '{{classname}}Controller@store', 'method' => 'post'] ) !!}
@endif

@if(isset($modal))
	@include("{{toLowerCase classname}}.modal")
@else
	@include("{{toLowerCase classname}}.form_partial")
    @yield('modal-body')
    @yield('modal-footer')	
@endif


{!! Form::close() !!}