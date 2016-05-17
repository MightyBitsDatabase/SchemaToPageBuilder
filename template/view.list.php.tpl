<div class="table-responsive">
    <table class="table table-bordered table-condensed table-hover table-striped">
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
            @if (count(${{toLowerCase classname}}))
            @foreach(${{toLowerCase classname}} as $row)
            <tr>
                {{#each column}}
                {{#ifcond name '!==' 'id'}}
                <td>\{{ $row->{{name}} }}</td>
                {{/ifcond}}
                {{/each}}
            
        <td><a href="\{{ action('{{classname}}Controller@show', $row->id) }}" class="btn btn-xs btn-default">detail</a> <a href="\{{ action('{{classname}}Controller@edit', $row->id) }}" onclick="lsdModal(this); return false;" class="btn btn-xs btn-default">edit</a> 

        <a href="\{{ action('{{classname}}Controller@destroy', $row->id) }}" class="btn btn-xs btn-default">delete</a></td>

            </tr>

            @endforeach
            @else
            <tr class="text-muted center">
                <td colspan="{{column.length}}">(No items to display)</td>
            </tr>
            @endif
        </tbody>
    </table>
    @if (isset($transaction->render))
    {!! $transaction->render() !!}
    @endif
</div>