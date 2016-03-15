defmodule JanrainGuardian.Router do
  use JanrainGuardian.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :janrain do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/", JanrainGuardian do
    pipe_through :browser
    pipe_through :browser_session

    get "/", PageController, :index
    resources "/users", UserController

    get "/login", SessionController, :new
  end

  scope "/", JanrainGuardian do
    pipe_through :janrain
    post "/login", SessionController, :create
  end


  # Other scopes may use custom stacks.
  # scope "/api", JanrainGuardian do
  #   pipe_through :api
  # end
end
