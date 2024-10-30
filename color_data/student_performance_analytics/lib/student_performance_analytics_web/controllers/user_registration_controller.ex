defmodule StudentPerformanceAnalyticsWeb.UserRegistrationController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Accounts
  alias StudentPerformanceAnalytics.Accounts.User  # Aliased explicitly
  import Phoenix.VerifiedRoutes  # Add this line
  def new(conn, _params) do
    changeset = Accounts.change_user_registration(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "Welcome! Please log in.")
        |> redirect(to: path(@router,~p"/users/log_in"))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
