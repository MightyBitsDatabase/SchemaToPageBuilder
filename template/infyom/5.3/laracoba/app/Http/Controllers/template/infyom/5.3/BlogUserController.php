<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateBlogUserRequest;
use App\Http\Requests\UpdateBlogUserRequest;
use App\Repositories\BlogUserRepository;

use App\Http\Controllers\AppBaseController;
use Illuminate\Http\Request;
use Flash;
use Prettus\Repository\Criteria\RequestCriteria;
use Response;

class BlogUserController extends AppBaseController
{
    /** @var  BlogUserRepository */
    private $BlogUserRepository;

    public function __construct(BlogUserRepository $BlogUserRepo)
    {
        $this->BlogUserRepository = $BlogUserRepo;
    }

    /**
     * Display a listing of the BlogUser.
     *
     * @param Request $request
     * @return Response
     */
    public function index(Request $request)
    {
        $this->BlogUserRepository->pushCriteria(new RequestCriteria($request));
        $BlogUser = $this->BlogUserRepository->all();

        return view('BlogUser.index')->with('BlogUser', $BlogUser);
    }

    /**
     * Show the form for creating a new BlogUser.
     *
     * @return Response
     */
    public function create()
    {
        return view('BlogUser.create');
    }

    /**
     * Store a newly created BlogUser in storage.
     *
     * @param CreateBlogUserRequest $request
     *
     * @return Response
     */
    public function store(CreateBlogUserRequest $request)
    {
        $input = $request->all();

        $BlogUser = $this->BlogUserRepository->create($input);

        Flash::success('BlogUser saved successfully.');

        return redirect(route('BlogUser.index'));
    }

    /**
     * Display the specified BlogUser.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function show($id)
    {
        $BlogUser = $this->BlogUserRepository->findWithoutFail($id);

        if (empty($BlogUser)) {
            Flash::error('BlogUser not found');

            return redirect(route('BlogUser.index'));
        }

        return view('BlogUser.show')->with('BlogUser', $BlogUser);
    }

    /**
     * Show the form for editing the specified BlogUser.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function edit($id)
    {
        $BlogUser = $this->BlogUserRepository->findWithoutFail($id);

        if (empty($BlogUser)) {
            Flash::error('BlogUser not found');

            return redirect(route('BlogUser.index'));
        }

        return view('BlogUser.edit')->with('BlogUser', $BlogUser);
    }

    /**
     * Update the specified BlogUser in storage.
     *
     * @param  int              $id
     * @param UpdateBlogUserRequest $request
     *
     * @return Response
     */
    public function update($id, UpdateBlogUserRequest $request)
    {
        $BlogUser = $this->BlogUserRepository->findWithoutFail($id);

        if (empty($BlogUser)) {
            Flash::error('BlogUser not found');

            return redirect(route('BlogUser.index'));
        }

        $BlogUser = $this->BlogUserRepository->update($request->all(), $id);

        Flash::success('BlogUser updated successfully.');

        return redirect(route('BlogUser.index'));
    }

    /**
     * Remove the specified BlogUser from storage.
     *
     * @param  int $id
     *
     * @return Response
     */
    public function destroy($id)
    {
        $BlogUser = $this->BlogUserRepository->findWithoutFail($id);

        if (empty($BlogUser)) {
            Flash::error('BlogUser not found');

            return redirect(route('BlogUser.index'));
        }

        $this->BlogUserRepository->delete($id);

        Flash::success('BlogUser deleted successfully.');

        return redirect(route('BlogUser.index'));
    }
}
