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