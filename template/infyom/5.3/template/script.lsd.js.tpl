        var lsdModal = function(e){
            //change form action to current page            
            var parent = e;
            var content_target = (parent.getAttribute('content-target'));
            $('#mainModalContent').html('Loading...');
            $('#mainModalContent').load(e.href, function(e){
                $('#mainModalContent').find('form').attr('content-target', content_target);
            })
            $('#mainModal').modal('show');
        }


        var postFormAjax = function (form, done, always)
        {
            var done = done;
            var always = always;
            $.post(form.attr('action'), form.serialize(), 'json').done(
            function(data){
                done();
            })
            .always(function(){
                always()
            }); 

        }

        var listenModalSubmit = function(){
            $(document).on('submit','#mainModal', function (e) {
                e.preventDefault();
                console.log($(e.target));
                var mainModal = $(e.target).closest('#mainModal');                
                var form  = $(e.target).closest('form');
                var modalBody  = $(e.target).find('.modal-body');
                var modalFooter  = $(e.target).find('.modal-footer');

                postFormAjax(form, function(){
                    modalBody.html("done");
                    var content_target = form.attr('content-target');
                     $('#' + content_target).load($('#' + content_target).attr('content-url'));
                }, function(){
                    console.log('always');
                });
            })  
        }


        var listenPaginator = function(){
            $(document).on('click','.tablePaginator a', function (e) {
                e.preventDefault();
                var target = ($(e.target).closest('.tablePaginator').attr('content-target'));
                $('#' + target).load(this.href);
            })      
        }







        $(function(){
            listenPaginator();
            listenModalSubmit();            
        })