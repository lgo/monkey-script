defmodule MonkeyScriptTest do
  use ExUnit.Case

  alias MonkeyScriptTestInfra, as: Infra

  test "infra dsl" do
    assert [%{name: "web worker", type: :name}, %{hosts: {:domain, "api.hackthenorth.com"}, type: :host}, %{type: :service, name: "mysql", port: 8000}, %{type: :service, name: "nginx", port: 80}] == Infra.get_infra()
  end
end
