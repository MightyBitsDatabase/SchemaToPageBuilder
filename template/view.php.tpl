<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>{{classname}} index</title>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <table class="table">
        <thead>
          <tr>
            {{#each column}}          
            <th>{{name}}</th>
            {{/each}}
          </tr>
        </thead>
        <tbody>
          
        @foreach (${{toLowerCase classname}} as $row)
        <tr>
          {{#each column}}          
          <td>\{{ $row->{{name}} }}</td>
          {{/each}}
        </tr>
        @endforeach

        </tbody>
      </table>
</body>
</html>