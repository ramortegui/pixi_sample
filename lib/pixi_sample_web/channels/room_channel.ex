defmodule PixiSampleWeb.RoomChannel do
  use PixiSampleWeb, :channel
  require Logger


  def join("room:lobby", payload, socket) do
    Logger.debug ("joined to a room")
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Logger.debug (body)
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

end
