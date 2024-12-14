defmodule Telegram do
  # Iterate over updates
  def iterate([update | rest], pid) do
    if rest != [] do
      process_update(update, pid)
      iterate(rest, pid)
    else
      process_update(update, pid)
    end
  end

  def message_commands(update, pid) do
    cond do
      !is_nil(update.message) ->
        message = update.message
        chat = update.message.chat.id

        if String.starts_with?(message.text, "/connect") do
          url = String.trim(String.replace_prefix(message.text, "/connect", ""))

          Nadia.send_message(chat, "Connecting to #{url}", [
            {:reply_to_message_id, message.message_id}
          ])

          connect(url, pid)
        end

      !is_nil(update.edited_message) ->
        message = update.edited_message
        chat = update.edited_message.chat.id

        if String.starts_with?(message.text, "/connect") do
          url = String.trim(String.replace_prefix(message.text, "/connect", ""))

          Nadia.send_message(chat, "Connecting to #{url}", [
            {:reply_to_message_id, message.message_id}
          ])

          connect(url, pid)
        end

      true ->
        nil
    end
  end

  # Process a single update
  def process_update(update, pid) do
    {update.update_id + 1, message_commands(update, pid)}
  end

  def connect(url, pid) do
    if url != "" do
      if !is_nil(pid) do
        Archipelago.kill(pid)
      end

      IO.puts(url)

      case Archipelago.start("wss://" <> url) do
        {:ok, pid} ->
          pid

        {:error, %{code: code, message: message}} ->
          IO.warn("Archipelago connection error " <> to_string(code) <> ": " <> message)
          nil

        {:error, error} ->
          IO.warn("Archipelago connection error: " <> to_string(error.original))
          nil
      end
    else
      pid
    end
  end

  def proc_update(offset, pid) do
    case Nadia.get_updates([{:offset, offset}]) do
      {:ok, []} ->
        {offset, pid}

      {:ok, updates} ->
        iterate(updates, pid)

      {:error, error} ->
        IO.puts(:fuk)
        {offset, pid}
    end
  end

  def run() do
  end

  def loop(offset, pid) do
    {offset_new, pid_new} = proc_update(offset, pid)
    loop(offset_new, pid_new)
  end
end
