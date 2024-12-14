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
    pid = Archipelago.start()
    Archipelago.send_message(pid, "Hello, world!")
    Telegram.loop(0)
  end
end
