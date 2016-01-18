jQuery ->
  loader = '<img src="/images/ajax-loader.gif" alt="Loading..." title="Loading..." />'

  $(document).on 'click', '.paginate-comments #show-more', ->
    pagination = $(this).prev()
    if pagination.size() > 0
      post_id = $(this).parent().attr('id')
      next_page = pagination.children('a.next_page').attr('href')
      page = next_page.split(/page=(\d+)\D*/)[1]
      if post_id
        pagination.html(loader).css('display', 'block')
        $.getScript '/more_comments/' + post_id + '/' + page
      return

  if $('#inf-scroll').size() > 0
    $(window).scroll ->
      more_posts_url = $('#inf-scroll .pagination a.next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('#inf-scroll .pagination').html(loader).css('display', 'block')
        $.getScript more_posts_url
      return
