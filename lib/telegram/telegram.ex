defmodule Telegram do
  # Iterate over updates
  def iterate([update | rest]) do
    if rest != [] do
      process_update(update)
      iterate(rest)
    else
      process_update(update)
    end
  end

  # Process a single update
  def process_update(update) do
    cond do
      !is_nil(update.message) ->
        message = update.message
        chat = update.message.chat.id

        if String.starts_with?(message.text, "/connect") do
          url = String.trim(String.replace_prefix(message.text, "/connect", ""))

          Nadia.send_message(chat, "Connecting to #{url}", [
            {:reply_to_message_id, message.message_id}
          ])

          connect(url, chat)
        end

      !is_nil(update.edited_message) ->
        message = update.edited_message
        chat = update.edited_message.chat.id

        if String.starts_with?(message.text, "/connect") do
          url = String.trim(String.replace_prefix(message.text, "/connect", ""))

          Nadia.send_message(chat, "Connecting to #{url}", [
            {:reply_to_message_id, message.message_id}
          ])

          connect(url, chat)
        end

      true ->
        nil
    end

    update.update_id + 1
  end

  def connect(url, chat) do
    IO.puts(url)
  end

  def proc_update(offset) do
    case Nadia.get_updates([{:offset, offset}]) do
      {:ok, []} ->
        offset

      {:ok, updates} ->
        iterate(updates)

      {:error, error} ->
        IO.puts(:fuk)
        offset
    end
  end

  def loop(offset) do
    loop(proc_update(offset))
  end
end
