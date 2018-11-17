defmodule PixiSampleWeb.PageController do
  use PixiSampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
