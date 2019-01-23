defmodule ChatWeb.RoomChannel do
  use ChatWeb, :channel

  alias Chat.Messages

  def join("room:main", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:main).
  def handle_in("shout", payload, socket) do
    with {:ok, _message} <- Messages.create_message(payload) do
      broadcast socket, "shout", payload
    else
      {:error, _error} ->
         push(socket, "error", %{"reason" => "Name or message can't be blank"})
    end
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
