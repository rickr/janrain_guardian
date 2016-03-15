defmodule JanrainGuardian.PageController do
  use JanrainGuardian.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: JanrainGuardian.Access


  def index(conn, _params) do
    render conn, "index.html"
  end
end
