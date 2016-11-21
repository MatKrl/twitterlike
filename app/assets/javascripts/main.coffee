$(document).on 'turbolinks:load', ->
  $('.toggle_comments').on 'click', (e) ->
    e.preventDefault()
    $(this).siblings('.comments-container').toggle()
  return