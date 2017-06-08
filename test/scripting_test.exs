defmodule MonkeyScriptScriptingTest do
  use ExUnit.Case
  import MonkeyScriptTestScript

  describe "modifier DSL" do
    test "executes main block" do
      assert catch_throw(
        test_action(1, nil) do
          throw :test
        end
        ) == :test
    end

    test "executes an pre-code action" do
      assert catch_throw(
        test_action(1, :before) do
          assert false, "This will fail if the before block doesn't throw"
        end
        ) == 1
    end

    test "executes an post-code action" do
      assert catch_throw(
        test_action(2, :after) do
          assert true, "This should always run, yet we still throw"
        end
        ) == 2
    end
  end
end
