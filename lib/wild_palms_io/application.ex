defmodule WildPalmsIo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WildPalmsIoWeb.Telemetry,
      # Start the Ecto repository
      WildPalmsIo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: WildPalmsIo.PubSub},
      # Start Finch
      {Finch, name: WildPalmsIo.Finch},
      # Start the Endpoint (http/https)
      WildPalmsIoWeb.Endpoint
      # Start a worker by calling: WildPalmsIo.Worker.start_link(arg)
      # {WildPalmsIo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WildPalmsIo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WildPalmsIoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
