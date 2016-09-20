@extends('layouts.app')

@section('content')
    <section class="content-header">
        <h1>
            Post
        </h1>
   </section>
   <div class="content">
       @include('adminlte-templates::common.errors')
       <div class="box box-primary">
           <div class="box-body">
               <div class="row">
                   {!! Form::model($Post, ['route' => ['Post.update', $Post->id], 'method' => 'patch']) !!}

                        @include('Post.fields')

                   {!! Form::close() !!}
               </div>
           </div>
       </div>
   </div>
@endsection