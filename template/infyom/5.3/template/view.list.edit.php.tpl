<div class="table-responsive">
    <table class="table  table-condensed table-hover table-striped">
        <thead>
            <tr>
                {{#each column}}
                {{#ifcond name '!==' 'id'}}
                <th>{{ucFirst name}}</th>
                {{/ifcond}}
                {{/each}}
            </tr>
        </thead>
        <tbody>
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