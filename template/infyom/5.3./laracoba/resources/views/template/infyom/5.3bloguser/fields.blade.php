<!-- username Field -->
<div class="form-group col-sm-6">
    {!! Form::label('username', 'username:') !!}
    {!! Form::text('username', null, ['class' => 'form-control']) !!}
</div>

<!-- password Field -->
<div class="form-group col-sm-6">
    {!! Form::label('password', 'password:') !!}
    {!! Form::text('password', null, ['class' => 'form-control']) !!}
</div>


<!-- Submit Field -->
<div class="form-group col-sm-12">
    {!! Form::submit('Save', ['class' => 'btn btn-primary']) !!}
    <a href="{!! route('BlogUser.index') !!}" class="btn btn-default">Cancel</a>
</div>
