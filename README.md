# ruby-mcp-template

Use [fast-mcp](https://github.com/yjacquin/fast-mcp) gem to easily spin up an MCP server.

## Installation

```sh
bin/install
```

## Development

```sh
bin/console
```

## Inspecting/testing MCP server

```sh
bin/inspector
```

## Running the MCP server

```sh
bin/mcp
```

## Generating MCP config

1. Start the inspector with `bin/inspector`
2. Click `Server File` to copy a full `mcp.json` to clipboard
3. Or click `Server Entry` to just copy the server entry that then can be placed in the `mcpServers` object in an `mcp.json` file
4. Or you can click `Server File` to copy the entire MCP configuration

### Example `Server File`

```json
{
    "mcpServers": {
        "default-server": {
            "command": "bin/mcp",
            "args": [],
            "env": {
                "HOME": "/Users/mgreenfield",
                "LOGNAME": "mgreenfield",
                "PATH": "<includes various runtimes>",
                "SHELL": "/bin/zsh",
                "TERM": "xterm-256color",
                "USER": "mgreenfield"
            }
        }
    }
}
```

### Example `Server Entry`

```json
{
    "command": "bin/mcp",
    "args": [],
    "env": {
        "HOME": "/Users/mgreenfield",
        "LOGNAME": "mgreenfield",
        "PATH": "<includes various runtimes>",
        "SHELL": "/bin/zsh",
        "TERM": "xterm-256color",
        "USER": "mgreenfield"
    }
}
```
