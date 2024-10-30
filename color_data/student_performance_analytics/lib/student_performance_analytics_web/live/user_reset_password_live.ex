defmodule StudentPerformanceAnalyticsWeb.UserResetPasswordLive do
  use StudentPerformanceAnalyticsWeb, :live_view
  alias StudentPerformanceAnalytics.Accounts
  import Phoenix.VerifiedRoutes  # Add this line
  import StudentPerformanceAnalyticsWeb.CoreComponents  # Import core components
  import StudentPerformanceAnalyticsWeb.FormComponents

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">Reset Password</.header>

      <.simple_form for={@form} id="reset_password_form" phx-submit="reset_password">
        <.input field={@form[:password]} type="password" placeholder="New Password" required />
        <:actions>
          <.button phx-disable-with="Resetting...">Reset Password</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("reset_password", %{"user" => user_params}, socket) do
    # Password reset logic
    {:noreply, socket |> put_flash(:info, "Password reset successfully.") |> redirect(to: Routes.user_session_path(socket, :new))}
  end
end
