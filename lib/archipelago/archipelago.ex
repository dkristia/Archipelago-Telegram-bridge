defmodule Archipelago do
  def start(url) do
    initial_state = %{}
    # {:ok, pid} = WSClient.connect(url, initial_state)
    # pid
    WSClient.connect(url, initial_state)
  end

  def send_message(pid, msg) do
    WebSockex.cast(pid, {:send, {:text, msg}})
  end

  def kill(pid) do
    WebSockex.stop(pid)
  end

  def send_connect(pid, opts \\ %{}) do
    payload = %{
      cmd: "Connect",
      password: opts[:password] || "",
      name: "Dasukimon",
      version: opts[:version] || "1.0.0",
      tags: opts[:tags] || [],
      items_handling: opts[:items_handling] || 0b111,
      uuid: opts[:uuid] || UUID.uuid4(),
      game: opts[:game] || "Archipelago",
      slot_data: opts[:slot_data] || false
    }

    Task.start(fn ->
      send_message(pid, Jason.encode!([payload]))
      # send_message(pid, Jason.encode!(%{cmd: "Get", keys: ["_read_race_mode"]}))
    end)
  end
end
