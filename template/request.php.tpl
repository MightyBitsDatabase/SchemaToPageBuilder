<?php namespace App\Http\Requests;

use App\Http\Requests\Request;

class {{classname}}Request extends BaseRequest {

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            {{#each column}}
            '{{name}}' => '',
            {{/each}}
        ];
    }

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }
}