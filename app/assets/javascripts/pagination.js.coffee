jQuery ->
  $(document).on 'click', '.paginate-comments #show-more', ->
    console.log("hey")
    if $(this).prev().size() > 0
      console.log("ho")
      post_id = $(this).parent().attr('id')
      next_page = $('.paginate-comments .pagination a.next_page').attr('href')
      page = next_page.split('page=')[1].replace(/\D/g,'');
      if post_id
        $('.paginate-comments .pagination').html('<img src="/images/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $('.paginate-comments .pagination').css('display', 'block')
        $.getScript '/more_comments/'+post_id+'/'+page
      return

  if $('#inf-scroll').size() > 0
    $(window).scroll ->
      more_posts_url = $('#inf-scroll .pagination a.next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('#inf-scroll .pagination').html('<img src="/images/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $('#inf-scroll .pagination').css('display', 'block')
        $.getScript more_posts_url
      return
