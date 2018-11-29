defmodule Sprite do
  @derive Jason.Encoder
  defstruct [velx: 0, vely: 0, lives: 5]

  @moduledoc """
  Documentation for Sprite.
  """

  defguardp is_alive?(lives) when is_integer(lives) and lives > 0

  def move_right(%Sprite{velx: velx, lives: lives} = sprite, quantity \\ 1) when is_alive?(lives) do
    %Sprite{ sprite | velx: quantity }
  end

  def move_left(%Sprite{velx: velx} = sprite, quantity \\ 1) do
    %Sprite{ sprite | velx: -1 * quantity }
  end

  def move_up(%Sprite{vely: vely} = sprite, quantity \\ 1) do
    %Sprite{ sprite | vely: (-1 * quantity)}
  end

  def move_down(%Sprite{vely: vely} = sprite, quantity \\ 1) do
    %Sprite{ sprite | vely: 1 * quantity }
  end

  def decrease_lives(%Sprite{lives: lives} = sprite, quantity) do
    %{sprite | lives: lives - quantity}
  end

  def alive?(%Sprite{lives: lives}) when is_alive?(lives), do: true
  def alive?(%Sprite{}), do: false
end
