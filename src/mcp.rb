require 'fast_mcp'
require 'singleton'

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

class ExampleTool < FastMcp::Tool
  description 'This is an example tool'

  arguments do
    required(:required_string).filled(:string).description('Some required argument')
    optional(:optional_integer).filled(:integer).description('Some optional arg')

    optional(:optional_hash).description('some optional hash').hash do
      optional(:key).filled(:string)
    end
  end

  def call(required_string:, optional_integer: nil, optional_hash: {})
    {
      required_string:,
      optional_integer:,
      optional_hash:,
    }
  end
end

Server.new(ExampleTool).start if ARGV.first == 'start'
