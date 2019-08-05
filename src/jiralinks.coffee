# Description:
#   Automatically post jira links when issue numbers are seen
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_JIRA_DOMAIN - domain when your jira instance lives (e.g. "example.atlassian.com")
#   HUBOT_JIRA_PROJECTS - comma separated list of project prefixes (e.g. "AB,CD,EF")
#   HUBOT_JIRA_INSECURE - if this is set urls will be prefixed by "http" instead of "https"
#
# Commands:
#   none
#
# Notes:
#   None
#
# Author:
#   Brad Clark <bdashrad@gmail.com>

module.exports = (robot) ->

  if process.env.HUBOT_JIRA_INSECURE?
    http_proto = 'http://'
  else
    http_proto = 'https://'

  if process.env.HUBOT_JIRA_PROJECTS
    regex = ///
      (?:^|\s) # start of line or space
      (#{process.env.HUBOT_JIRA_PROJECTS.split(',').join('|')}) # list of jira project prefixes
      - # a hyphen
      (\d+) # one or more digits
      \b # word boundary
      ///ig # case insensitive
  else
    regex = ///
      (?:^|\s) # start of line or space
      ([a-z]+) # one or more letters
      -
      (\d+) # one or more digits
      \b # word boundary
      ///ig

  robot.hear regex, (res) ->
    # return if msg.subtype is 'bot_message'
    urlify = (match) -> http_proto + process.env.HUBOT_JIRA_DOMAIN + '/browse/' + match.trim()
    notify = (msg) -> res.send msg

    # Found unique here: https://maxrohde.com/2014/04/01/remove-duplicates-from-array-in-coffeescript/
    unique = (tickets) ->
      if tickets.length == 0
        return []
      res = {}
      res[tickets[key]] = tickets[key] for key in [0..tickets.length-1]
      value for key, value of res

    notify urlify match for match in unique(res.match)
