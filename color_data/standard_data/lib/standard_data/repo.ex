defmodule StandardData.Repo do
  use Ecto.Repo,
    otp_app: :standard_data,
    adapter: Ecto.Adapters.Postgres
end
