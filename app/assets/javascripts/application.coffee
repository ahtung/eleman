#= require jquery
#= require jquery_ujs
#= require foundation
#= require websocket_rails/main
#= require bxslider-4

$ ->
  $(document).foundation()

  find_member_pos = (task) ->
    member_name = task.member[0]
    list_item = $("img[title='#{member_name}']").first().parent()
    return $("#slider-0").find('li').index(list_item)

  sliders = []
  $('.bxslider').each (i, obj) ->
    sliders[i] = $(this).bxSlider(
      auto: false,
      speed: 200,
      pause: 500,
      controls: false,
      pager: false,
      captions: true
    )

    if sliders[i].data('complete')
      sliders[i].stopAuto()
      member_pos = find_member_pos(
        member: [sliders[i].data('best'), -1]
      )
      if member_pos != -1
        sliders[i].goToSlide(member_pos + 1)
    else
      sliders[i].startAuto()


  ws_url = $('#employee-ul').data('ws-url')
  dispatcher = new WebSocketRails(ws_url)
  channel = dispatcher.subscribe('sync')
  channel.bind('syncer', (task) ->
    perc = parseInt(task.month) * 100 / 12
    $("span.meter").css('width', "#{perc}%")
    if parseInt(task.month) == 12
      setTimeout(() ->
        $("span.meter").parent().fadeOut()
      , 250)

    member_pos = find_member_pos(task)
    if member_pos != -1
      sliders[parseInt(task.month) - 1].stopAuto()
      sliders[parseInt(task.month) - 1].goToSlide(member_pos + 1)
  )

  $(".alert-box").delay(1500).fadeOut "slow"
