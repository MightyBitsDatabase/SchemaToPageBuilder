<?php
use Illuminate\Database\Seeder;
use App\\{{model.classname}};

class {{model.name}}TableSeeder extends Seeder {
    public function run()
    {
        DB::table('{{toLowerCase model.name}}')->delete();

        {{#each seeds}}
        ${{toLowerCase ../model.name}} = new {{../model.classname}}();        
        {{#each this}}
        ${{toLowerCase ../../model.name}}->{{@key}} = "{{this}}";
        {{/each}}
        ${{toLowerCase ../model.name}}->save();

        {{/each}}
    }
}