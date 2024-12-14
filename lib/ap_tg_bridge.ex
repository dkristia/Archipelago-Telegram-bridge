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
    bot_token = System.get_env("TOKEN")
    IO.puts(bot_token)
    IO.puts("Hello, world!")
  end
end
