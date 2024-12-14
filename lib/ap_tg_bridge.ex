defmodule ApTgBridge do
  @moduledoc """
  Documentation for `ApTgBridge`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ApTgBridge.hello()
      :world

  """
  def hello do
    :world
  end

  def run do
    # PidChannelMap.start_link()
    # pid = Archipelago.start("wss://archipelago.gg:38453")
    # Archipelago.send_connect(pid, %{
    #  password: "pvl",
    #  version: "1.0.0",
    #  tags: [],
    #  items_handling: nil,
    #  uuid: UUID.uuid4(),
    #  game: "Pokemon Emerald",
    #  slot_data: false
    # })
    Telegram.loop(0, nil)
  end
end
