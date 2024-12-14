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
    IO.puts(update.message.text)

    Nadia.send_message(update.message.chat.id, update.message.text, [
      {:reply_to_message_id, update.message.message_id}
    ])

    update.update_id + 1
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
