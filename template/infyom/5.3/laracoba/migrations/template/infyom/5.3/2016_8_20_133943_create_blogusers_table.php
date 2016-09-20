<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBlogusersTable extends Migration {

  /**
   * Run the migrations.
   *
   * @return void
   */
  public function up()
  {
    Schema::create('blogusers', function(Blueprint $table) {

        $table->increments('id');
        $table->string('username')->default("bogus");
        $table->string('password');
        $table->text('profile');
        $table->timestamps();
      
    });
  }

  /**
   * Reverse the migrations.
   *
   * @return void
   */
  public function down()
  {
    Schema::drop('blogusers');
  }
}