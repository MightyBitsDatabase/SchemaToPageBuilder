<?

/**
* 
*/
class ListHelper
{
	{{#each this}}

	{{#each relation_array.belongsTo}}

	public static function list{{cameLize table_class}}()
	{
		$model = App()->make('App\\{{ucFirst table_class}}');
		return $model->lists('{{relatedcolumn}}', 'id'); 
	}

	{{/each}}
	{{/each}}

}