defmodule MonkeyScriptTestScript do
  import MonkeyScript.Scripting
  require Logger

  modifier :test_action, [input, when_to_throw] do
    if when_to_throw == :before do
      throw input
    end
  after
    if when_to_throw == :after do
      throw input
    end
  end
end
