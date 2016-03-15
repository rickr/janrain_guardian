defmodule JanrainGuardian.Access do
  require Logger
  use JanrainGuardian.Web, :controller

  def unauthenticated(conn, _params) do
    redirect conn, to: "/login"
  end
end
