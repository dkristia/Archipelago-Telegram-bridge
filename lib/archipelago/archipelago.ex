defmodule Archipelago do
  def start(url) do
    initial_state = %{}
    {:ok, pid} = WSClient.connect(url, initial_state)
    pid
  end

  def send_message(pid, msg) do
    WebSockex.cast(pid, {:send, {:text, msg}})
  end

  def kill(pid) do
    WebSockex.stop(pid)
  end

end
