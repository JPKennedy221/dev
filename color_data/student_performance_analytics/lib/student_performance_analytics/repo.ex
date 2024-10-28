defmodule StudentPerformanceAnalytics.Repo do
  use Ecto.Repo,
    otp_app: :student_performance_analytics,
    adapter: Ecto.Adapters.Postgres
end
