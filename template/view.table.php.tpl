<div class="table-responsive">

      {!! Form::open(array('action' => ['{{classname}}Controller@store'], 'method' => 'POST', 'content-target' => 'Table{{classname}}')) !!}

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
      @foreach (${{toLowerCase classname}} as $row)
      <tr>
           {{#each column}}
           {{#ifcond name '!==' 'id'}}
        
        {{#if relation}}
        <td><a href="\{{ action('{{ucFirst relation.name}}Controller@show', $row->{{toLowerCase name}} ) }}"  >\{{ $row->{{toLowerCase relation.name}}_{{relation.relatedcolumn}} }}</a></td>
        {{else}}

        <td>\{{ $row->{{name}} }}</td>
        {{/if}}
           {{/ifcond}}
           {{/each}}
        <td><a href="\{{ action('{{classname}}Controller@show', $row->id) }}" class="btn btn-xs btn-default">detail</a> <a href="\{{ action('{{classname}}Controller@edit', $row->id) }}" onclick="lsdModal(this); return false;" class="btn btn-xs btn-default">edit</a> 

        <a href="\{{ action('{{classname}}Controller@destroy', $row->id) }}" class="btn btn-xs btn-default">delete</a></td>
      </tr>
      @endforeach
    </tbody>
  </table>
  <div content-target="Table{{classname}}" class="tablePaginator">
    {!! ${{toLowerCase classname}}->render() !!}        
  </div>

      {!! Form::close() !!}
</div>