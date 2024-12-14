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

  defp process_message(msg, state) do
    case Jason.decode(msg) do
      {:ok, %{"cmd" => "RoomInfo"} = data} ->
        IO.inspect(data, label: "RoomInfo")
      {:ok, %{"cmd" => "DataPackage"} = data} ->
        IO.inspect(data, label: "DataPackage")
      {:ok, %{"cmd" => "Connected"} = data} ->
        IO.inspect(data, label: "Connected")
      {:ok, %{"cmd" => "ReceivedItems"} = data} ->
        IO.inspect(data, label: "ReceivedItems")
      {:ok, %{"cmd" => "Print"} = data} ->
        IO.inspect(data, label: "Print")
      {:ok, %{"cmd" => "PrintJSON"} = data} ->
        IO.inspect(data, label: "PrintJSON")
      {:error, _} ->
        IO.puts("Failed to decode message: #{msg}")
    end
  end
end
