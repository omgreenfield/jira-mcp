require 'dotenv'
require 'fast_mcp'
require 'faraday'

require_relative 'jira_client'

Dotenv.load

class Server
  def initialize(*tools)
    tools.each do |tool|
      server.register_tool(tool)
    end
  end

  def server
    @server ||= FastMcp::Server.new(name: 'test MCP server', version: '1.0.0')
  end

  def start
    server.start
  end
end

class GetJiraIssue < FastMcp::Tool
  description 'Get information from a Jira issue'

  arguments do
    required(:issue_key).filled(:string).description('Jira issue key (e.g. "KEY-123")')
  end

  def call(issue_key:)
    issue_json = JiraClient.new.get_issue(issue_key)

    {
      key: issue_key,
      epic_key: epic_key(issue_json),
      hours_logged: hours_logged(issue_json),
      estimated_hours: estimated_hours(issue_json),
      title: title(issue_json),
      description: description(issue_json),
      status: status(issue_json),
      comments: comments(issue_json),
      assignee: assignee(issue_json),
      priority: priority(issue_json),
      reporter: reporter(issue_json),
      labels: labels(issue_json),
      sprint: sprint(issue_json),
    }
  end

  private def epic_key(issue_json)
    issue_json.dig('fields', 'customfield_10014')
  end

  private def hours_logged(issue_json)
    worklogs = issue_json.dig('fields', 'worklog', 'worklogs') || []
    total_seconds = worklogs.sum { |w| w['timeSpentSeconds'] || 0 }
    total_seconds / 3600.0
  end

  private def estimated_hours(issue_json)
    seconds = issue_json.dig('fields', 'timeoriginalestimate')
    seconds ? seconds / 3600.0 : nil
  end

  private def title(issue_json)
    issue_json.dig('fields', 'summary')
  end

  private def description(issue_json)
    issue_json.dig('fields', 'description')
  end

  private def status(issue_json)
    issue_json.dig('fields', 'status', 'name')
  end

  private def comments(issue_json)
    (issue_json.dig('fields', 'comment', 'comments') || []).map do |comment|
      {
        timestamp: comment['created'],
        author: comment.dig('author', 'displayName'),
        body: comment['body'],
      }
    end
  end

  private def assignee(issue_json)
    issue_json.dig('fields', 'assignee', 'displayName')
  end

  private def priority(issue_json)
    issue_json.dig('fields', 'priority', 'name')
  end

  private def reporter(issue_json)
    issue_json.dig('fields', 'reporter', 'displayName')
  end

  private def labels(issue_json)
    issue_json.dig('fields', 'labels') || []
  end

  private def sprint(issue_json)
    sprints = issue_json.dig('fields', 'customfield_10021')
    return unless sprints.is_a?(Array) && !sprints.empty?

    sprints.first['name']
  end
end

Server.new(GetJiraIssue).start if ARGV.first == 'start'
