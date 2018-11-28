defmodule PixiSampleWeb.RoomChannel do
  use PixiSampleWeb, :channel
  require Logger

  def join("room:lobby", payload, socket) do
    Logger.debug ("joined to a room")
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    client_id = socket.assigns[:client_id]
    pid = Process.whereis(client_id)
    notify(client_id, PixiSample.SpriteServer.status(pid), socket)
    {:noreply, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Logger.debug (body)
    Logger.debug (IO.inspect socket.assigns[:client_id])
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_in("move","up", socket) do
    client_id = socket.assigns[:client_id]
    pid = Process.whereis(client_id)
    PixiSample.SpriteServer.move_up(pid, 5)
    notify(client_id, PixiSample.SpriteServer.status(pid), socket)
    {:noreply, socket}
  end

  def handle_in("move","down", socket) do
    client_id = socket.assigns[:client_id]
    pid = Process.whereis(client_id)
    PixiSample.SpriteServer.move_down(pid, 5)
    notify(client_id, PixiSample.SpriteServer.status(pid), socket)
    {:noreply, socket}
  end

  def handle_in("move","left", socket) do
    client_id = (socket.assigns[:client_id])
    pid = Process.whereis(client_id)
    PixiSample.SpriteServer.move_left(pid, 5)
    notify(client_id, PixiSample.SpriteServer.status(pid), socket)
    {:noreply, socket}
  end

  def handle_in("move","right", socket) do
    client_id = (socket.assigns[:client_id])
    pid = Process.whereis(client_id)
    PixiSample.SpriteServer.move_right(pid, 5)
    notify(client_id, PixiSample.SpriteServer.status(pid), socket)
    {:noreply, socket}
  end

  defp notify(client_id, sprite_server, socket) do
      broadcast!(socket, "update", %{sprite: client_id, data: sprite_server})
  end
end
