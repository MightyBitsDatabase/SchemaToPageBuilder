@section('modal-body')
{{#each column}}
{{#if relation}}

@unless(isset($hidden['{{toLowerCase relation.relatedmodel}}_id']))
<div class="form-group">
  <label for="{{relatedmodel}}_{{relatedcolumn}}">{{relation.relatedmodel}} {{ucFirst relation.relatedcolumn}}</label>
  {!! Form::select('{{toLowerCase relation.relatedmodel}}_id', ListHelper::list{{ucFirst relation.relatedmodel}}(), null, ['class' => 'form-control']) !!}
</div>
@endunless

{{else}}
{{#ifcond name '!==' 'id'}}
<div class="form-group">
  <label for="{{name}}">{{ucFirst name}}</label>

  {{#ifcond type '!==' 'datetime'}}
  
  {{#ifcond uploadfile '===' true}}
  {!! Form::file('{{name}}', null, ['class' => 'form-control']) !!}  
  {{else}}
  {!! Form::text('{{name}}', null, ['class' => 'form-control']) !!}
  {{/ifcond}}

  {{else}}
  {!! Form::text('{{name}}', null, ['class' => 'form-control datepicker']) !!}
  {{/ifcond}}



</div>
{{/ifcond}}
{{/if}}
{{/each}}
@stop

@section('modal-footer')
<div class="form-group">
  {!! Form::submit('Update {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
</div>
@stop
