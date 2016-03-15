defmodule JanrainGuardian.SessionController do
  require Logger

  use JanrainGuardian.Web, :controller

  alias JanrainGuardian.User

  def new(conn, _params), do: render conn, "new.html"


  def create(conn, %{"token" => token}) do
    profile_data = Janrain.authenticate_user_with(token)
    Logger.debug "Profile Data: #{inspect profile_data}"
  end
end
