defmodule MonkeyScript.Scripts.Networking do
  import MonkeyScript.Scripting
  require Logger

  modifier :block_port, [port] do
    Logger.debug("Disabling #{port}")
  after
    Logger.debug("Enabled #{port}")
  end

  def ping(port) when is_number(port) do
    true
  end
end
