# Description:
#   Receives github PR notifications and forwards mentions to the chat.
#
# Notes:
#   The scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.router.post '/github/webhook', (req, res) ->
    title = req.body?.pull_request?.title
    body = req.body?.pull_request?.body
  
    pr_message = "#{title} #{body}"
    
    direct_mentions = pr_message.match(/@([\w\-]+)/g)
    channel_mentions = pr_message.match(/#([\w\-]+)/g)
    
    robot.send {room: "kevinmook"}, "I got a request from the webhook: Direct mentions: #{direct_mentions}, room mentions #{channel_mentions}"
  
    res.send 'OK'
