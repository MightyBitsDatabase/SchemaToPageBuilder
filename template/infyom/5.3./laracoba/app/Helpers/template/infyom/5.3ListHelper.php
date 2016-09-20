<?

/**
* 
*/
class ListHelper
{



	public static function listBloguser()
	{
		$model = App()->make('App\Bloguser');
		return $model->lists('id', 'id'); 
	}


}