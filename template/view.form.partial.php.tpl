{{#each column}}
{{#if relation}}
<div class="form-group">
  <label for="{{relatedmodel}}_{{relatedcolumn}}">{{relation.relatedmodel}} {{ucFirst relation.relatedcolumn}}</label>
  {!! Form::select('{{toLowerCase relation.relatedmodel}}_id', ${{toLowerCase relation.relatedmodel}}, isset(${{toLowerCase ../../classname}}) ? ${{toLowerCase ../../classname}}->{{toLowerCase relation.relatedmodel}}_id  : '1', ['class' => 'form-control']) !!}
</div>
{{else}}
{{#ifcond name '!==' 'id'}}
<div class="form-group">
  <label for="{{name}}">{{ucFirst name}}</label>
  {!! Form::text('{{name}}', null, ['class' => 'form-control']) !!}
</div>
{{/ifcond}}
{{/if}}
{{/each}}
<div class="form-group">
  {!! Form::submit('Update {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
</div>