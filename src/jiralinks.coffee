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
      ///i # case insensitive
  else
    regex = ///
      (?:^|\s) # start of line or space
      ([a-z]+) # one or more letters
      -
      (\d+) # one or more digits
      \b # word boundary
      ///i

  robot.hear regex, (res) ->
    # return if msg.subtype is 'bot_message'
    project = res.match[1].toUpperCase()
    id = res.match[2]
    issue = project + '-' + id
    url = http_proto + process.env.HUBOT_JIRA_DOMAIN + '/browse/' + issue
    res.send url
