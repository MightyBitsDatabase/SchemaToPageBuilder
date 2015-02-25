    {!! Form::model( ${{toLowerCase classname}}, ['action' => ['{{classname}}Controller@edit', ${{toLowerCase classname}}->id], 'method' => 'post'] ) !!}
    
    {{#each column}}

   {{#if relation}}
    <div class="form-group">
      <label for="{{relatedmodel}}_{{relatedcolumn}}">{{relation.relatedmodel}} {{ucFirst relation.relatedcolumn}}</label>
      {!! Form::select('{{toLowerCase relation.relatedmodel}}_id', ${{toLowerCase relation.relatedmodel}},  ${{toLowerCase ../../classname}}->{{toLowerCase relation.relatedmodel}}_id, ['class' => 'form-control']) !!}
    </div>
   {{else}}
    <div class="form-group">
      <label for="{{name}}">{{ucFirst name}}</label>
      {!! Form::text('{{name}}', null, ['class' => 'form-control']) !!}
    </div>
   {{/if}}

    {{/each}}

    <div class="form-group">
      {!! Form::submit('Update {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
      {!! Form::submit('Delete {{ucFirst classname}}', ['class' => 'btn btn-danger']) !!}
    </div>
    {!! Form::close() !!}