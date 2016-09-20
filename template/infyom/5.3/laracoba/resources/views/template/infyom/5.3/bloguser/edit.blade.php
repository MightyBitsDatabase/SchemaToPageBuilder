@extends('layouts.app')

@section('content')
    <section class="content-header">
        <h1>
            BlogUser
        </h1>
   </section>
   <div class="content">
       @include('adminlte-templates::common.errors')
       <div class="box box-primary">
           <div class="box-body">
               <div class="row">
                   {!! Form::model($BlogUser, ['route' => ['BlogUser.update', $BlogUser->id], 'method' => 'patch']) !!}

                        @include('BlogUser.fields')

                   {!! Form::close() !!}
               </div>
           </div>
       </div>
   </div>
@endsection