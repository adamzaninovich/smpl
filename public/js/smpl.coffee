Updater =
  client:       undefined
  channel:      undefined
  subscription: undefined
  
  init:()->
    # channel must match that in config/config.yml
    @channel = '/smpl/log'
    @
  
  start:()->
    @connect()
    @subscribe()
    @
  
  connect:()->
    @setStatus('Connecting...')
    @client = new Faye.Client('/faye')
    @
  
  subscribe:()->
    @setStatus('Subscribing...')
    @subscription = @client.subscribe(@channel, @receiveData)
    @subscription.callback ()->Updater.setStatus('Subscribed')
    @
  
  receiveData:(data)->
    row = $('<tr></tr>')
    row.append $('<td></td>').text(new Date(data.time).toLocaleTimeString())
    row.append $('<td></td>').text(data.ip)
    [sizecol, datacol] = if data.type isnt 'data' then ['--', data.type] else [data.size, data.line]
    row.append $('<td></td>').text(sizecol)
    row.append $('<td></td>').text(datacol)
    $('#logs').prepend(row)
    chart.series[0].addPoint([data.time,data.size], true, (chart.series[0].data.length > 20))
    console.log data
    return
  
  setStatus:(text) ->
    $('#status').text(text)
    return

($ document).ready () -> Updater.init().start()