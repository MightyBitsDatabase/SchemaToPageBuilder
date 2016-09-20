<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreatePostRequest;
use App\Http\Requests\UpdatePostRequest;
use App\Repositories\PostRepository;

use App\Http\Controllers\AppBaseController;
use Illuminate\Http\Request;
use Flash;
use Prettus\Repository\Criteria\RequestCriteria;
use Response;

class PostController extends AppBaseController
{
    /** @var  PostRepository */
    private $PostRepository;

    public function __construct(PostRepository $PostRepo)
    {
        $this->PostRepository = $PostRepo;
    }

    /**
     * Display a listing of the Post.
     *
     * @param Request $request
     * @return Response
     */
    public function index(Request $request)
    {
        $this->PostRepository->pushCriteria(new RequestCriteria($request));
        $Post = $this->PostRepository->all();

        return view('Post.index')->with('Post', $Post);
    }

    /**
     * Show the form for creating a new Post.
     *
     * @return Response
     */
    public function create()
    {
        return view('Post.create');
    }

    /**
     * Store a newly created Post in storage.
     *
     * @param CreatePostRequest $request
     *
     * @return Response
     */
    public function store(CreatePostRequest $request)
    {
        $input = $request->all();

        $Post = $this->PostRepository->create($input);

        Flash::success('Post saved successfully.');

        return redirect(route('Post.index'));
    }

    /**
     * Display the specified Post.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function show($id)
    {
        $Post = $this->PostRepository->findWithoutFail($id);

        if (empty($Post)) {
            Flash::error('Post not found');

            return redirect(route('Post.index'));
        }

        return view('Post.show')->with('Post', $Post);
    }

    /**
     * Show the form for editing the specified Post.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function edit($id)
    {
        $Post = $this->PostRepository->findWithoutFail($id);

        if (empty($Post)) {
            Flash::error('Post not found');

            return redirect(route('Post.index'));
        }

        return view('Post.edit')->with('Post', $Post);
    }

    /**
     * Update the specified Post in storage.
     *
     * @param  int              $id
     * @param UpdatePostRequest $request
     *
     * @return Response
     */
    public function update($id, UpdatePostRequest $request)
    {
        $Post = $this->PostRepository->findWithoutFail($id);

        if (empty($Post)) {
            Flash::error('Post not found');

            return redirect(route('Post.index'));
        }

        $Post = $this->PostRepository->update($request->all(), $id);

        Flash::success('Post updated successfully.');

        return redirect(route('Post.index'));
    }

    /**
     * Remove the specified Post from storage.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function destroy($id)
    {
        $Post = $this->PostRepository->findWithoutFail($id);

        if (empty($Post)) {
            Flash::error('Post not found');

            return redirect(route('Post.index'));
        }

        $this->PostRepository->delete($id);

        Flash::success('Post deleted successfully.');

        return redirect(route('Post.index'));
    }
}
