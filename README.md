# MonkeyScript

MonkeyScript is a framework to help you write automated resiliency tests. It provides you an easy way describe scenarios for a fleet of servers, which can be run automatically.

```elixir
# First, we define our infrastructure using the Infra DSL
defmodule Infra do
  use MonkeyScript.Scripting.Infra

  name "app-server" do
    # The host is used to access the server for command and control (SSH)
    hosts domain: "hackthenorth.com"

    service "mysql", port: 5432
    service "nginx", port: 80
  end

  monkeyscript_finish()
end


test "can still hit homepage if mysql is down" do
  block_port(Infra, "app-server", service: "mysql") do
    assert true == ping(Infra, "app-server")
  end
end

test "web worker restarts if mysql is down" do
  block_port(Infra, "app-server", service: "mysql") do
    restart_worker(Infra, "app-server")
    :timer.sleep(:timer.seconds(10))
    assert true == ping(Infra, "app-server")
  end
end
```

## Prereqs

- `iptables`
- `ping`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `monkey_script` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:monkey_script, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/monkey_script](https://hexdocs.pm/monkey_script).
