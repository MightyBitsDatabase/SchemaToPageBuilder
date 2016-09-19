<?php

namespace {{{NAMESPACE_REPOSITORY}}};

use {{{NAMESPACE_MODEL}}}\\{{{MODEL_NAME}}};
use InfyOm\Generator\Common\BaseRepository;

class {{{MODEL_NAME}}}Repository extends BaseRepository
{
    /**
     * @var array
     */
    protected $fieldSearchable = [
        {{{FIELDS}}}
    ];

    /**
     * Configure the Model
     **/
    public function model()
    {
        return {{{MODEL_NAME}}}::class;
    }
}
