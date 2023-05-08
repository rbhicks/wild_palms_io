defmodule WildPalmsIoWeb.Router do
  use WildPalmsIoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WildPalmsIoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WildPalmsIoWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/content_items", ContentItemLive.Index, :index
    live "/content_items/new", ContentItemLive.Index, :new
    live "/content_items/:id/edit", ContentItemLive.Index, :edit

    live "/content_items/:id", ContentItemLive.Show, :show
    live "/content_items/:id/show/edit", ContentItemLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", WildPalmsIoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:wild_palms_io, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WildPalmsIoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
