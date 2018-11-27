defmodule Sprite do
  @derive Jason.Encoder
  defstruct [posx: 0, posy: 0, lives: 5]

  @moduledoc """
  Documentation for Sprite.
  """

  defguardp is_alive?(lives) when is_integer(lives) and lives > 0

  def move_right(%Sprite{posx: posx, lives: lives} = sprite, quantity \\ 1) when is_alive?(lives) do
    %Sprite{ sprite | posx: posx + quantity }
  end

  def move_left(%Sprite{posx: posx} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posx: posx - quantity }
  end

  def move_up(%Sprite{posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posy: posy + quantity }
  end

  def move_down(%Sprite{posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posy: posy - quantity }
  end

  def move_upper_left(%Sprite{posx: posx, posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posx: posx - quantity, posy: posy + quantity }
  end

  def move_upper_right(%Sprite{posx: posx, posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posx: posx + quantity, posy: posy + quantity }
  end

  def move_lower_left(%Sprite{posx: posx, posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posx: posx - quantity, posy: posy - quantity }
  end

  def move_lower_right(%Sprite{posx: posx, posy: posy} = sprite, quantity \\ 1) do
    %Sprite{ sprite | posx: posx + quantity, posy: posy - quantity }
  end

  def decrease_lives(%Sprite{lives: lives} = sprite, quantity) do
    %{sprite | lives: lives - quantity}
  end

  def alive?(%Sprite{lives: lives}) when is_alive?(lives), do: true
  def alive?(%Sprite{}), do: false
end
