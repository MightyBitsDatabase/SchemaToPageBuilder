<table class="table table-responsive" id="Post-table">
    <thead>

<th>id</th>
<th>title</th>
<th>content</th>
<th>blogusers_id</th>


        <th colspan="3">Action</th>
    </thead>
    <tbody>
    @foreach($Post as $Post)
        <tr>

<td>{!! $Post->id !!}</td>
<td>{!! $Post->title !!}</td>
<td>{!! $Post->content !!}</td>
<td>{!! $Post->blogusers_id !!}</td>


            <td>
                {!! Form::open(['route' => ['Post.destroy', $Post->id], 'method' => 'delete']) !!}
                <div class='btn-group'>
                    <a href="{!! route('Post.show', [$Post->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-eye-open"></i></a>
                    <a href="{!! route('Post.edit', [$Post->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-edit"></i></a>
                    {!! Form::button('<i class="glyphicon glyphicon-trash"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                </div>
                {!! Form::close() !!}
            </td>
        </tr>
    @endforeach
    </tbody>
</table>