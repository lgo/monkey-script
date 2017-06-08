defmodule MonkeyScriptScriptsNetworkingTest do
  use ExUnit.Case
  import MonkeyScript.Scripts.Networking
  import MonkeyScript.Scripts.Util

  alias MonkeyScriptTestInfra, as: Infra

  describe "networking scripts" do
    test "db down but site up" do
      block_port(get_port_for_service(Infra, "mysql")) do
        assert true == ping(80)
      end
    end

    @tag :skip
    test "nginx down, site down" do
      block_port(get_port_for_service(Infra, "nginx")) do
        assert false == ping(80)
      end
    end
  end
end
