defmodule MonkeyScriptScriptsUtilTest do
  use ExUnit.Case
  import MonkeyScript.Scripts.Util

  alias MonkeyScriptTestInfra, as: Infra

  describe "get_service/2" do
    test "no services" do
      assert nil == get_service([], "mysql")
    end

    test "no matching services" do
      assert nil == get_service([%{type: :service, name: "notme"}, %{type: :service, name: "notme2"}], "mysql")
    end

    test "matching service" do
      assert %{type: :service, name: "mysql"} == get_service([%{type: :service, name: "mysql"}, %{type: :service, name: "notme2"}], "mysql")
    end

    test "with module" do
      assert %{type: :service, name: "mysql", port: 8000} == get_service(Infra, "mysql")
    end

    @tag :skip
    # Currently no multi-service handling
    test "multiple matching services" do
      assert %{type: :service, name: :mysql} == get_service([%{type: :service, name: "mysql"}, %{type: :service, name: "mysql"}], "mysql")
    end
  end

  describe "get_port_for_service/2" do
    test "matching service" do
      assert 8000 == get_port_for_service(Infra, "mysql")
    end
  end
end
