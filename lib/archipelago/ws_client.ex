defmodule WSClient do
  use WebSockex

  def connect(url, state) do
    WebSockex.start_link(url, __MODULE__, state)
  end

  def handle_frame({:text, msg}, state) do
    IO.puts("Received message: #{msg}")
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts("Sending #{type} frame with payload: #{msg}")
    {:reply, frame, state}
  end
end
