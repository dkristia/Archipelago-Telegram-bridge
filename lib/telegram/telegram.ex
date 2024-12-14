defmodule Telegram do
  def proc_update(offset) do
    case Nadia.get_updates([{:offset, offset}]) do
      {:ok, [update | _rest]} ->
        IO.puts(update.message.text)

        Nadia.send_message(update.message.chat.id, update.message.text, [
          {:reply_to_message_id, update.message.message_id}
        ])

        update.update_id + 1

      {:ok, []} ->
        offset

      {:error, error} ->
        IO.puts(:fuk)
        offset
    end
  end

  def loop(offset) do
    loop(proc_update(offset))
  end
end
