<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Lifepatch Manager</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Font-Awesome -->
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
        
        <!-- Datepicker -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.1/css/datepicker.min.css">



        <!-- Lavish -->
        <link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}">



        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
        <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>
        <style>

      * {
  -webkit-border-radius: 0 !important;
     -moz-border-radius: 0 !important;
          border-radius: 0 !important;
}        


.well, .navbar-inner, .popover, .btn, .tooltip, input, select, textarea, pre, .progress, .modal, .add-on, .alert, .table-bordered, .nav>.active>a, .dropdown-menu, .tooltip-inner, .badge, .label, .img-polaroid {
-moz-box-shadow: none !important;
-webkit-box-shadow: none !important;
box-shadow: none !important;
-webkit-border-radius: 0px !important;
-moz-border-radius: 0px !important;
border-radius: 0px !important;
border-collapse: collapse !important;
background-image: none !important;
} 


.page-header {
    padding-bottom: 9px;
    margin: 20px 0px 20px;
    border-bottom: 1px solid #EEE;
}

.modal-header {
    min-height: 16.43px;
    padding: 15px;
    border-bottom: 1px solid #CCC;
    color: #505050;
}


.modal-body {
    position: relative;
    padding: 15px;
    background-color: #FFF;
}

        </style>
    </head>
    <body>
        <nav class="navbar navbar-default  navbar-inverse navbar-static-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Lifepatch Manager</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        @if (Auth::user())
                        <li><a href="/">Home</a></li>
                        <li><a href="#">Timeline</a></li>
                        <li><a href="#">Reports</a></li>
                        <li><a href="#">Import</a></li>

                        <li></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Database <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li>
                                    <a href="/blogusers"><i class="fa fa-table fa-fw"></i> BlogUsers</a>
                                </li>
                                <li>
                                    <a href="/posts"><i class="fa fa-table fa-fw"></i> Posts</a>
                                </li>
                                <li class="divider"></li>
                                <li class="dropdown-header">Nav header</li>
                                <li><a href="#">Separated link</a></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li>
                        @endif
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    @if (Auth::guest())
                        <li><a href="{{ url('/auth/login') }}">Login</a></li>
                    @else
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">{{ Auth::user()->name }} <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="{{ url('/auth/logout') }}">Logout</a></li>
                            </ul>
                        </li>
                    @endif                    </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </nav>
            <div class="container">
                
                @yield('content')
            </div>
            <!-- Modal -->
            <div class="modal" id="mainModal" tabindex="-1" role="dialog" aria-labelledby="mainModalTitle" aria-hidden="true">
                <div class="modal-dialog">
                    <div id="mainModalContent" class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="mainModalTitle">Modal title</h4>
                        </div>
                        <div class="modal-body">
                            Loading....
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            
            <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
            <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
            <script>window.jQuery || document.write('<script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js"><\/script>')</script>
            <!-- Include all compiled plugins (below), or include individual files as needed -->
            <script src="//netdna.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
            <!-- Datepicker -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.1/js/bootstrap-datepicker.min.js"></script>
            <script src="{{ asset('js/lsd.js') }}"></script>
        </body>
    </html>