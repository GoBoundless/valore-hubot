# Description:
#   Receives github PR notifications and forwards mentions to the chat.
#
# Notes:
#   The scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.router.post '/github/webhook', (req, res) ->
    action = req.body?.action || "unknown"
    title = req.body?.pull_request?.title || ""
    body = req.body?.pull_request?.body || ""
    pr_url = req.body?.pull_request?.html_url
  
    switch action
      when "opened"
        pr_message = "#{title} #{body}"
        
        direct_mentions = pr_message.match(/@[\w\-]+/g) || []
        channel_mentions = pr_message.match(/#[\w\-]+/g) || []
        
        common_message = "mentioned in a new pull request, '#{title}', available here: #{pr_url}"
        
        for username in direct_mentions
          username = username.replace(/^@/, "")     # get rid of the @
          # note: with the slack adapter, "room" can be a room or a username
          robot.send {room: username}, "You were #{common_message}"

        for channel in channel_mentions
          channel = channel.replace(/^#/, "")     # get rid of the #
          robot.send {room: channel}, "This channel was #{common_message}"
  
    res.send 'OK'
