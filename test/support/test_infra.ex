defmodule MonkeyScriptTestInfra do
  use MonkeyScript.Scripting.Infra

  name "web worker"
  hosts domain: "api.hackthenorth.com"
  service "mysql", port: 8000
  service "nginx", port: 80

  monkeyscript_finish()
end
