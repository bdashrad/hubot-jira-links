# Description:
#   Automatically post jira links when issue numbers are seen
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_JIRA_DOMAIN - domain when your jira instance lives (e.g. "example.atlassian.com")
#   HUBOT_JIRA_PROJECTS - comma separated list of project prefixes (e.g. "AB,CD,EF")
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

  if process.env.HUBOT_JIRA_PROJECTS
    regex = ///
      \b # word boundary
      (#{process.env.HUBOT_JIRA_PROJECTS.split(',').join('|')}) # list of jira project prefixes
      - # a hyphen
      (\d+) # one or more digits
      \b # word boundary
      ///i # case insensitive
  else
    regex = ///
      \b # word boundary
      ([a-z]+) # one or more letters
      -
      (\d+) # one or more digits
      \b # word boundary
      ///i

  robot.hear regex, (res) ->
    project = res.match[1].toUpperCase()
    id = res.match[2]
    issue = project + '-' + id
    url = 'https://' + process.env.HUBOT_JIRA_DOMAIN + '/browse/' + issue
    res.send url
