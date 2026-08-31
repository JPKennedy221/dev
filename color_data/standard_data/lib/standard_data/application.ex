defmodule StandardData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StandardDataWeb.Telemetry,
      StandardData.Repo,
      {DNSCluster, query: Application.get_env(:standard_data, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StandardData.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StandardData.Finch},
      # Start a worker by calling: StandardData.Worker.start_link(arg)
      # {StandardData.Worker, arg},
      # Start to serve requests, typically the last entry
      StandardDataWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StandardData.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StandardDataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
