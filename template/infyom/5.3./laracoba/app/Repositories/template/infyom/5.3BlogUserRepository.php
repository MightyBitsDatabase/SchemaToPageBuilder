<?php

namespace App\Repositories;

use App\Models\BlogUser;
use InfyOm\Generator\Common\BaseRepository;

class BlogUserRepository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        	'username',	
	'password',	
	'profile'
    ];

    /**
     * Configure the Model
     **/
    public function model()
    {
        return BlogUser::class;
    }
}
