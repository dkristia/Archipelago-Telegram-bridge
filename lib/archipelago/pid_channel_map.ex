defmodule PidChannelMap do
  use Agent

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def put(pid, channel) do
    Agent.update(__MODULE__, fn map -> Map.put(map, pid, channel) end)
  end

  def delete(pid) do
    Agent.update(__MODULE__, fn map -> Map.delete(map, pid) end)
  end

  def get(pid) do
    Agent.get(__MODULE__, fn map -> Map.get(map, pid) end)
  end
end
