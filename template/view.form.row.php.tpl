
<tr>
    {{#each column}}
    {{#if relation}}
    <td>
        {!! Form::select('{{toLowerCase relation.relatedmodel}}_id', ListHelper::list{{ucFirst relation.relatedmodel}}(), null, ['class' => 'form-control']) !!}
    </td>
    {{else}}
    {{#ifcond name '!==' 'id'}}
    <td>
        {!! Form::text('{{name}}', null, ['class' => 'form-control']) !!}
    </td>
    {{/ifcond}}
    {{/if}}
    {{/each}}
    <td>
        {!! Form::submit('Add {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
    </td>
</tr>
