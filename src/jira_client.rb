require 'base64'

class JiraClient
  attr_reader :connection, :base_url, :username, :password

  def initialize
    @base_url = ENV.fetch('JIRA_BASE_URL')
    @username = ENV.fetch('JIRA_USERNAME')
    @password = ENV.fetch('JIRA_API_TOKEN')
    @connection = Faraday.new(url: @base_url) do |f|
      f.headers['Authorization'] = "Basic #{Base64.strict_encode64("#{@username}:#{@password}")}"
      f.headers['Content-Type'] = 'application/json'
    end
  end

  def get(path, params = {})
    response = connection.get(path, params)

    return JSON.parse(response.body) if response.success?

    raise "Jira API Error (#{response.status}): #{response.body}"
  end

  def post(path, body = {})
    response = connection.post(path) do |req|
      req.body = JSON.generate(body)
    end

    return JSON.parse(response.body) if response.success?

    raise "Jira API Error (#{response.status}): #{response.body}"
  end

  # @param time_spent [String] e.g. '1.5h', '1h 15m'
  def submit_hours_logged(issue_key, start_time:, time_spent:, comment: '')
    path = "rest/api/2/issue/#{issue_key}"
    body = {
      timeSpent: time_spent,
      comment:,
      started: start_time.utc.strftime('%Y-%m-%dT%H:%M:%S.000+0000'),
    }

    post(path, body)
  end

  def get_issue(issue_key)
    get("/rest/api/2/issue/#{issue_key}")
  end
end
