<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Backpack\CRUD\CrudTrait;

class {{{MODEL_NAME}}} extends Model {

  use CrudTrait;

    /*
  |--------------------------------------------------------------------------
  | GLOBAL VARIABLES
  |--------------------------------------------------------------------------
  */

  protected $table = '{{{toLowerCase TABLE_NAME}}}';
  // protected $primaryKey = 'id';
  // protected $guarded = [];
  // protected $hidden = ['id'];
  protected $fillable = [{{{FIELDS}}}];
  public $timestamps = true;

  /*
  |--------------------------------------------------------------------------
  | FUNCTIONS
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | RELATIONS
  |--------------------------------------------------------------------------
  */

  {{#each model.relations}}

  public function {{this.name}}()
  {
    {{#if this.usenamespace}}    
    return $this->{{this.relationtype}}('\\{{this.usenamespace}}\\{{this.relatedmodel}}');
    {{else}}
    return $this->{{this.relationtype}}('\App\\{{this.relatedmodel}}');
    {{/if}}
  }

  {{/each}}

  /*
  |--------------------------------------------------------------------------
  | SCOPES
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | ACCESORS
  |--------------------------------------------------------------------------
  */

  /*
  |--------------------------------------------------------------------------
  | MUTATORS
  |--------------------------------------------------------------------------
  */
  

  {{#each column}}

  {{#ifcond html_input '===' 'file'}}
  public function setImageAttribute($value)
      {
          $attribute_name = "image";
          $disk = "public";
          $destination_path = "folder_1/subfolder_1";

          $this->uploadFileToDisk($value, $attribute_name, $disk, $destination_path);
      }
  {{/ifcond}}

  {{#ifcond html_input '===' 'imageupload'}}

public function setImageAttribute($value)
    {
        $attribute_name = "image";
        $disk = "public_folder";
        $destination_path = "uploads/folder_1/subfolder_3";

        // if the image was erased
        if ($value==null) {
            // delete the image from disk
            \Storage::disk($disk)->delete($this->image);

            // set null in the database column
            $this->attributes[$attribute_name] = null;
        }

        // if a base64 was sent, store it in the db
        if (starts_with($value, 'data:image'))
        {
            // 0. Make the image
            $image = \Image::make($value);
            // 1. Generate a filename.
            $filename = md5($value.time()).'.jpg';
            // 2. Store the image on disk.
            \Storage::disk($disk)->put($destination_path.'/'.$filename, $image->stream());
            // 3. Save the path to the database
            $this->attributes[$attribute_name] = $destination_path.'/'.$filename;
        }
    }


  {{/ifcond}}
  {{/each}}





}
