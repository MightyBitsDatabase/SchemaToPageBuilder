<?php
use Illuminate\Database\Seeder;
use App\\{{classname}};

class {{name}}TableSeeder extends Seeder {
    public function run()
    {
        DB::table('{{toLowerCase name}}')->delete();

        {{#each seeds}}
        ${{toLowerCase ../name}} = new {{../classname}}();        
        {{#each this}}
        ${{toLowerCase ../../name}}->{{@key}} = "{{this}}";
        {{/each}}
        ${{toLowerCase ../name}}->save();

        {{/each}}
    }
}