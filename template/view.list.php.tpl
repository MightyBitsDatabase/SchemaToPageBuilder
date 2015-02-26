<div class="table-responsive">
    <table class="table table-condensed table-hover table-striped">
        <thead>
            <tr>
                {{#each column}}
                {{#ifcond name '!==' 'id'}}
                <th>{{ucFirst name}}</th>
                {{/ifcond}}
                {{/each}}
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                {!! Form::open(array('action' => ['{{classname}}Controller@store'], 'method' => 'POST')) !!}
                {{#each column}}
                {{#ifcond name '!==' 'id'}}
                <td><input type="text" name="{{name}}" class="date form-control input-sm" data-parsley-required="true" value=""> </td>
                {{/ifcond}}
                {{/each}}
                <td>
                    {!! Form::submit('Add {{ucFirst classname}}', ['class' => 'btn btn-primary']) !!}
                </td>
                {!! Form::close() !!}
            </tr>
            @foreach (${{toLowerCase classname}} as $row)
            <tr>
                {{#each column}}
                {{#ifcond name '!==' 'id'}}
                <td>\{{ $row->{{name}} }}</td>
                {{/ifcond}}
                {{/each}}
                <td><a href="#" class="btn btn-xs btn-default">detail</a> <a href="\{{ action('{{classname}}Controller@edit', $row->id) }}" class="btn btn-xs btn-default">edit</a> <a href="#" class="btn btn-xs btn-default">delete</a></td>
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
@if (isset($transaction->render))
{!! $transaction->render() !!}
@endif
</div>