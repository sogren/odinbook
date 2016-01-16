jQuery ->
  if $('#inf-scroll').size() > 0
    $(window).scroll ->
      more_posts_url = $('.pagination a.next_page').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').html('<img src="/images/ajax-loader.gif" alt="Loading..." title="Loading..." />')
        $('.pagination').css('display', 'block')
        $.getScript more_posts_url
      return
