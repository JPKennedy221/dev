defmodule StudentPerformanceAnalyticsWeb.UserForgotPasswordLive do
  use StudentPerformanceAnalyticsWeb, :live_view
  alias StudentPerformanceAnalytics.Accounts
  import Phoenix.VerifiedRoutes  # Add this line
  import StudentPerformanceAnalyticsWeb.CoreComponents  # Import core components
  import StudentPerformanceAnalyticsWeb.FormComponents
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        Forgot Your Password?
        <:subtitle>Enter your email to reset your password</:subtitle>
      </.header>

      <.simple_form for={@form} id="forgot_password_form" phx-submit="send_reset_link">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <:actions>
          <.button phx-disable-with="Sending...">Send Reset Link</.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={Routes.user_registration_path(@socket, :new)}>Register</.link>
        | <.link href={Routes.user_session_path(@socket, :new)}>Log in</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_reset_link", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &Routes.user_reset_password_url(socket, :edit, &1)
      )
    end

    info = "If your email is registered, a reset link will be sent shortly."
    {:noreply, socket |> put_flash(:info, info) |> redirect(to: Routes.page_path(socket, :index))}
  end
end
