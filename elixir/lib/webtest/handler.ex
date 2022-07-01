defmodule Webtest.Handler do
  @moduledoc """
  A Plug that always responds with a string
  """
  import Plug.Conn

  def init(options) do
    options
  end

  @doc """
  Simple route that returns a string
  """
  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    :timer.sleep(100)
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "This is my website!\n")
  end
end
