defmodule Archipelago do
  def start do
    initial_state = %{}
    {:ok, pid} = WSClient.connect(initial_state)
    pid
  end

  def send_message(pid, msg) do
    WebSockex.cast(pid, {:send, {:text, msg}})
  end

end
