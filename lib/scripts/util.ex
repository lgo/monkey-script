defmodule MonkeyScript.Scripts.Util do

  def get_service([%{type: :service, name: name} = service | _], name), do: service
  def get_service([_| rest], name), do: get_service(rest, name)
  def get_service([], _), do: nil
  def get_service(module, service), do: get_service(module.get_infra(), service)

  def get_port_for_service(module, service) when is_bitstring(service) do
    get_service(module, service)[:port]
  end

end
