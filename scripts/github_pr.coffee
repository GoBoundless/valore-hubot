# Description:
#   Receives github PR notifications and forwards mentions to the chat.
#
# Notes:
#   The scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.router.post '/github/webhook', (req, res) ->
    data   = JSON.parse req.body.payload
  
    title = data?.pull_request?.title
    body = data?.pull_request?.body
  
    robot.send {room: "kevinmook"}, "#{title} ... #{body}"
  
    res.send 'OK'
