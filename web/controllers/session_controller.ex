defmodule JanrainGuardian.SessionController do
  require Logger

  use JanrainGuardian.Web, :controller

  alias JanrainGuardian.User

  def new(conn, _params), do: render conn, "new.html"


  def create(conn, %{"token" => token}) do
    profile_data = Janrain.authenticate_user_with(token)
    Logger.debug "Profile Data: #{inspect profile_data}"

    identifier = profile_data |> extract_identifier

    case identifier do
      {:ok, identifier} ->
        conn
        |> save_new_user(identifier)
        |> Guardian.Plug.sign_in(identifier)
        |> redirect(to: "/")
      {:failed} ->
        conn
        |> put_flash(:error, "Uhoh! We failed to log you in. =(")
        |> redirect(to: "/login")
    end
  end

  defp extract_identifier(user_details) do
    case user_details do
      %{"profile" => %{"identifier" => identifier}} ->
        {:ok, identifier}
      _ ->
        Logger.debug("Failed to extract identifier:")
        Logger.debug(inspect user_details)
        {:failed}
    end
  end

  defp save_new_user(conn, identifier) do
    Logger.debug "Checking if #{identifier} is new user: #{User.new?(identifier)}"
    if User.new?(identifier), do:  save_identifier identifier
    conn
  end

  defp save_identifier(identifier) do
    Logger.debug "Saving user with identifier #{identifier}"
    changeset = User.changeset(%User{}, %{identity: identifier})
    case Repo.insert(changeset) do
      {:ok, _user} ->
        Logger.debug "Inserted"
      {:error, _changeset} ->
        Logger.error "Unable to create user for identifier #{identifier}"
    end
  end
end
