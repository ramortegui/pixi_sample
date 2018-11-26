defmodule PixiSample.SpriteServer do
  use GenServer

  def init(%Sprite{} = initial_state), do: {:ok, initial_state}

  def handle_cast({:move_left, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_left(sprite, quantity)}
  end

  def handle_cast({:move_right, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_right(sprite, quantity)}
  end

  def handle_cast({:move_up, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_up(sprite, quantity)}
  end

  def handle_cast({:move_down, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_down(sprite, quantity)}
  end

  def handle_cast({:move_upper_left, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_upper_left(sprite, quantity)}
  end

  def handle_cast({:move_upper_right, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_upper_right(sprite, quantity)}
  end

  def handle_cast({:move_lower_left, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_lower_left(sprite, quantity)}
  end

  def handle_cast({:move_lower_right, quantity}, %Sprite{} = sprite) do
    {:noreply, Sprite.move_lower_right(sprite, quantity)}
  end

  def handle_call(:status, _from, %Sprite{} = sprite) do
    {:reply, sprite, sprite}
  end

  def move_left(pid, qty) do
    GenServer.cast(pid, {:move_left, qty})
  end

  def move_right(pid, qty) do
    GenServer.cast(pid, {:move_right, qty})
  end

  def move_up(pid, qty) do
    GenServer.cast(pid, {:move_up, qty})
  end

  def move_upper_left(pid, qty) do
    GenServer.cast(pid, {:move_upper_left, qty})
  end

  def move_upper_right(pid, qty) do
    GenServer.cast(pid, {:move_upper_right, qty})
  end

  def move_lower_left(pid, qty) do
    GenServer.cast(pid, {:move_lower_left, qty})
  end

  def move_lower_right(pid, qty) do
    GenServer.cast(pid, {:move_lower_right, qty})
  end

  def move_down(pid, qty) do
    GenServer.cast(pid, {:move_down, qty})
  end

  def status(pid) do
    GenServer.call(pid, :status)
  end
end
