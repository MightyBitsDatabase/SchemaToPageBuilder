<table class="table table-responsive" id="BlogUser-table">
    <thead>

<th>id</th>
<th>username</th>
<th>password</th>
<th>profile</th>


        <th colspan="3">Action</th>
    </thead>
    <tbody>
    @foreach($BlogUser as $BlogUser)
        <tr>

<td>{!! $BlogUser->id !!}</td>
<td>{!! $BlogUser->username !!}</td>
<td>{!! $BlogUser->password !!}</td>
<td>{!! $BlogUser->profile !!}</td>


            <td>
                {!! Form::open(['route' => ['BlogUser.destroy', $BlogUser->id], 'method' => 'delete']) !!}
                <div class='btn-group'>
                    <a href="{!! route('BlogUser.show', [$BlogUser->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-eye-open"></i></a>
                    <a href="{!! route('BlogUser.edit', [$BlogUser->id]) !!}" class='btn btn-default btn-xs'><i class="glyphicon glyphicon-edit"></i></a>
                    {!! Form::button('<i class="glyphicon glyphicon-trash"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                </div>
                {!! Form::close() !!}
            </td>
        </tr>
    @endforeach
    </tbody>
</table>