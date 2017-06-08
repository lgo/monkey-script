defmodule MonkeyScript.Scripting do
  defmacro modifier(name, argument_names, [do: do_clause, after: after_clause]) do
    func_name = String.to_atom(Atom.to_string(name) <> "_z")
    quote do
      defmacro unquote(name)(unquote_splicing(argument_names), [do: code]) do
        argument_names = unquote(argument_names)
        func_name = unquote(func_name)
        quote do
          unquote(func_name)(unquote_splicing(argument_names), true)
          unquote(code)
          unquote(func_name)(unquote_splicing(argument_names), false)
        end
      end

      defmacro unquote(name)(unquote_splicing(argument_names), do_or_undo) when is_boolean(do_or_undo) do
        argument_names = unquote(argument_names)
        func_name = unquote(func_name)
        quote do
          unquote(func_name)(unquote_splicing(argument_names), do_or_undo)
        end
      end

      def unquote(func_name)(unquote_splicing(argument_names), true) do
        unquote(do_clause)
      end

      def unquote(func_name)(unquote_splicing(argument_names), false) do
        unquote(after_clause)
      end
    end
  end
end
