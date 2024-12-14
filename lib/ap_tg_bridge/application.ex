defmodule ApTgBridge.Application do
  use Application

  def start(_type, _args) do
    ApTgBridge.run()
    {:ok, self()}
  end
end
