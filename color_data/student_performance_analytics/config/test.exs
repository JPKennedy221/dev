import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :student_performance_analytics, StudentPerformanceAnalytics.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "student_performance_analytics_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :student_performance_analytics, StudentPerformanceAnalyticsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "M8hw6Ah7qBpYe6eF5lk/FpiEqn4clDmU4CuLI+bN6+n75eM79VDPvVmPQylQgPxy",
  server: false

# In test we don't send emails
config :student_performance_analytics, StudentPerformanceAnalytics.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
