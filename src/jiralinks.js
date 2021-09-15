/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * DS207: Consider shorter variations of null checks
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
// Description:
//   Automatically post jira links when issue numbers are seen
//
// Dependencies:
//   None
//
// Configuration:
//   HUBOT_JIRA_DOMAIN - domain when your jira instance lives (e.g. "example.atlassian.com")
//   HUBOT_JIRA_PROJECTS - comma separated list of project prefixes (e.g. "AB,CD,EF")
//   HUBOT_JIRA_INSECURE - if this is set urls will be prefixed by "http" instead of "https"
//
// Commands:
//   none
//
// Notes:
//   None
//
// Author:
//   Brad Clark <bdashrad@gmail.com>

module.exports = function(robot) {

  let http_proto, regex;
  if (process.env.HUBOT_JIRA_INSECURE != null) {
    http_proto = 'http://';
  } else {
    http_proto = 'https://';
  }

  if (process.env.HUBOT_JIRA_PROJECTS) {
    regex = new RegExp(`\
(?:^|\\s)\
(${process.env.HUBOT_JIRA_PROJECTS.split(',').join('|')})\
-\
(\\d+)\
\\b\
`, 'i'); // case insensitive
  } else {
    regex = new RegExp(`\
(?:^|\\s)\
([a-z]+)\
-\
(\\d+)\
\\b\
`, 'i');
  }

  return robot.hear(regex, function(res) {
    // return if msg.subtype is 'bot_message'
    const project = res.match[1].toUpperCase();
    const id = res.match[2];
    const issue = project + '-' + id;
    const url = http_proto + process.env.HUBOT_JIRA_DOMAIN + '/browse/' + issue;
    return res.send(url);
  });
};
