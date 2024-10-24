defmodule StudentPerformanceAnalytics.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StudentPerformanceAnalyticsWeb.Telemetry,
      StudentPerformanceAnalytics.Repo,
      {DNSCluster, query: Application.get_env(:student_performance_analytics, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StudentPerformanceAnalytics.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StudentPerformanceAnalytics.Finch},
      # Start a worker by calling: StudentPerformanceAnalytics.Worker.start_link(arg)
      # {StudentPerformanceAnalytics.Worker, arg},
      # Start to serve requests, typically the last entry
      StudentPerformanceAnalyticsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StudentPerformanceAnalytics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StudentPerformanceAnalyticsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
