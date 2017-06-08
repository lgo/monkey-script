defmodule MonkeyScript.Scripting.Infra do

  @doc false
  defmacro __using__(_opts) do
    quote do
      import MonkeyScript.Scripting.Infra
      Module.put_attribute(__MODULE__, :monkeyscript_infra, [])
    end
  end

  @doc false
  defmacro monkeyscript_finish do
    quote do
      # FIXME: replace this with an after_compile type check for transition consistency
      # but we still want this at runtime :(
      def get_infra do
        @monkeyscript_infra
      end
    end
  end

  defmacro put_infra(option) do
    quote do
      Module.put_attribute(__MODULE__, :monkeyscript_infra, Module.get_attribute(__MODULE__, :monkeyscript_infra) ++ [unquote(option)])
    end
  end

  defmacro name(name) do
    quote do
      put_infra(%{
        type: :name,
        name: unquote(name),
      })
    end
  end

  defmacro hosts([domain: domain]) do
    quote do
      put_infra(%{
        type: :host,
        hosts: {:domain, unquote(domain)}
      })
    end
  end

  defmacro service(name, [port: port]) do
    quote do
      put_infra(%{
        type: :service,
        name: unquote(name),
        port: unquote(port),
      })
    end
  end

end
