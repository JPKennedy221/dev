defmodule StudentPerformanceAnalytics.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      StudentPerformanceAnalyticsWeb.Telemetry,
      # DNS-based service discovery and clustering
      {DNSCluster, query: Application.get_env(:student_performance_analytics, :dns_cluster_query) || :ignore},
      # Start the PubSub system
      {Phoenix.PubSub, name: StudentPerformanceAnalytics.PubSub},
      # Start the Finch HTTP client for sending emails and external requests
      {Finch, name: StudentPerformanceAnalytics.Finch},
      # Start the Endpoint (http/https), typically the last entry
      StudentPerformanceAnalyticsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: StudentPerformanceAnalytics.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Handle configuration changes during runtime
  @impl true
  def config_change(changed, _new, removed) do
    StudentPerformanceAnalyticsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
