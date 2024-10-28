defmodule StudentPerformanceAnalyticsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :student_performance_analytics

  # Serve at "/" the static files from "priv/static" directory.
  plug Plug.Static,
    at: "/",
    from: :student_performance_analytics,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  # Ensure proper request parsing (including multipart forms)
  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # Session management setup
  plug Plug.Session,
    store: :cookie,
    key: "_student_performance_analytics_key",
    signing_salt: "some_salt"

  # Attach the main router for request handling
  plug StudentPerformanceAnalyticsWeb.Router

  socket "/live", Phoenix.LiveView.Socket

end
