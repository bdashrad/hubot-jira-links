# hubot-jiralinks

[![Build Status](https://travis-ci.org/bdashrad/hubot-jiralinks.svg)](https://travis-ci.org/bdashrad/hubot-jiralinks/)

hubot scipt that recognized jira issue numbers and respond with their urls

See [`src/jiralinks.coffee`](src/jiralinks.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-jira-links --save`

Then add **hubot-jira-links** to your `external-scripts.json`:

```json
["hubot-jira-links"]
```

## Configuration
### Required:
* `HUBOT_JIRA_DOMAIN` - domain when your jira instance lives (e.g. "example.atlassian.com")
### Optional:
* `HUBOT_JIRA_PROJECTS` - comma separated list of project prefixes (e.g. "AB,CD,EF")

If you don't set `HUBOT_JIRA_PROJECTS`, any pattern of [a-zA-Z]-#### will be linked

## Sample Interaction

```
user >> jira-1234
hubot>> https://example.jira.com/browse/JIRA-1234
```

## NPM Module

https://www.npmjs.com/package/hubot-jira-links
