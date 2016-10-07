# hubot-jiralinks

A hubot script that recognizes jira issues and responds with the link.

See [`src/jiralinks.coffee`](src/jiralinks.coffee) for full documentation

## Installation

In hubot project repo, run:

`npm install hubot-jiralinks --save`

Then add **hubot-jiralinks** to your `external-scripts.json`:

```json
[
  "hubot-jiralinks"
]
```

## Configuration
### Required:
* `HUBOT_JIRA_DOMAIN` - domain when your jira instance lives (e.g. "example.atlassian.com")
### Optional:
* HUBOT_JIRA_PROJECTS - comma separated list of project prefixes (e.g. "AB,CD,EF")
If you don't set HUBOT_JIRA_PROJECTS, any patter of [a-zA-Z]-#### will be linked

## Sample Interaction

```
user >> jira-1234
hubot>> https://example.jira.com/browse/JIRA-1234

## NPM Module

https://www.npmjs.com/package/hubot-jiralinks
