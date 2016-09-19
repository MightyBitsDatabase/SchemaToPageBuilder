var tmp_model = {};



tmp_model.NAMESPACE_APP  = "App\\";
tmp_model.NAMESPACE_REPOSITORY  = "App\\Repositories";
tmp_model.NAMESPACE_MODEL = "App\\Models"
tmp_model.NAMESPACE_DATATABLES = ""
tmp_model.NAMESPACE_MODEL_EXTEND = "Eloquent"
tmp_model.NAMESPACE_API_CONTROLLER = ""
tmp_model.NAMESPACE_API_REQUEST = ""
tmp_model.NAMESPACE_BASE_CONTROLLER = "App\\Http\\Controllers"
tmp_model.NAMESPACE_CONTROLLER = "App\\Http\\Controllers";
tmp_model.NAMESPACE_REQUEST  = "App\\Http\\Requests";
tmp_model.NAMESPACE_REQUEST_BASE = "App\\Http\\Requests"

tmp_model.TABLE_NAME = ""
tmp_model.MODEL_NAME  = ""
tmp_model.MODEL_NAME_CAMEL  = ""
tmp_model.MODEL_NAME_PLURAL = ""
tmp_model.MODEL_NAME_SNAKE = ""
tmp_model.MODEL_NAME_PLURAL_CAMEL  = ""
tmp_model.MODEL_NAME_PLURAL_SNAKE  = ""
tmp_model.MODEL_NAME_PLURAL_DASHED = ""
tmp_model.MODEL_NAME_DASHED = ""
tmp_model.MODEL_NAME_HUMAN  = ""
tmp_model.MODEL_NAME_PLURAL_HUMAN = ""

//model
tmp_model.SOFT_DELETE_IMPORT = "use Illuminate\\Database\\Eloquent\\SoftDeletes;"
tmp_model.SOFT_DELETE = "use SoftDeletes;"
tmp_model.SOFT_DELETE_DATES = "protected $dates = [\'deleted_at\'];"

tmp_model.DOCS = ""

tmp_model.TIMESTAMPS = ""
tmp_model.PRIMARY = ""
tmp_model.FIELDS = ""
tmp_model.CAST = ""
tmp_model.RULES = ""
tmp_model.RELATIONS = []

tmp_model.RENDER_TYPE  = "all()";
tmp_model.VIEW_PREFIX  = "";
tmp_model.ROUTE_NAMED_PREFIX  = "";

tmp_model.ROUTE_NAMED_PREFIX = "";
tmp_model.ROUTE_PREFIX = "";
tmp_model.PATH_PREFIX = "";


tmp_model.API_PREFIX = "api"
tmp_model.API_VERSION = "v1"


//custom

tmp_model.FIELDS_COMPILED = "" //store compiled fields template


// /**
//      * @return \Illuminate\Database\Eloquent\Relations\$RELATIONSHIP_CLASS$
//      **/
//     public function $FUNCTION_NAME$()
//     {
//         return $this->$RELATION$(\$NAMESPACE_MODEL$\$RELATION_MODEL_NAME$::class$INPUT_FIELDS$);
//     }
 // [ { extramethods: '',
 //       foreignkeys: 'account_id',
 //       name: 'transactions',
 //       relatedmodel: 'Transaction',
 //       relatedcolumn: '',
 //       relationtype: 'hasMany',
 //       usenamespace: '' },
 //     { extramethods: '',
 //       foreignkeys: '',
 //       name: 'folder',
 //       relatedmodel: 'Folder',
 //       relatedcolumn: 'name',
 //       relationtype: 'belongsTo',
 //       usenamespace: '' } ] }


tmp_model.createRelation = function(func_name, relation_type) {
	tmp_model.RELATIONS.push({
		FUNCTION_NAME: func_name,
		RELATION: relation_type,
		NAMESPACE_MODEL: tmp_model.NAMESPACE_MODEL
	})
}

module.exports = tmp_model