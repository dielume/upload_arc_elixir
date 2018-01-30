defmodule UploadWeb.PageController do
  use UploadWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
