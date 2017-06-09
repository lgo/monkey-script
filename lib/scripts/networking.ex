defmodule MonkeyScript.Scripts.Networking do
  import MonkeyScript.Scripting
  require Logger

  modifier :block_port, [port] do
    Logger.debug("Disabling port=#{port}")
    System.cmd("iptables", ["-A", "INPUT", "-p", "tcp", "--dport", port, "-j", "DROP"])
    System.cmd("iptables", ["-A", "OUTPUT", "-p", "tcp", "--dport", port, "-j", "DROP"])
  after
    Logger.debug("Enabled port=#{port}")
    # FIXME: this doesn't support nested port blocks
    System.cmd("iptables", ["-D", "INPUT", "1"])
    System.cmd("iptables", ["-D", "OUTPUT", "1"])
  end

  def ping(port) when is_number(port) do
    Logger.debug("Pinging port=#{port}")
    # FIXME: return status of ping
    System.cmd("ping", ["localhost:#{port}"])
    true
  end
end
