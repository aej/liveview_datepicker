defmodule LiveviewDatepicker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveviewDatepickerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveviewDatepicker.PubSub},
      # Start the Endpoint (http/https)
      LiveviewDatepickerWeb.Endpoint
      # Start a worker by calling: LiveviewDatepicker.Worker.start_link(arg)
      # {LiveviewDatepicker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveviewDatepicker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveviewDatepickerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
