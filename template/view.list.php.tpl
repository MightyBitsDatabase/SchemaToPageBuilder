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
            </td>
        </tr>
        @endforeach
    </tbody>
</table>
@if (isset($transaction->render))
{!! $transaction->render() !!}
@endif
</div>