defmodule StudentPerformanceAnalyticsWeb.UserRegistrationLive do
  use StudentPerformanceAnalyticsWeb, :live_view
  alias StudentPerformanceAnalytics.Accounts
  import Phoenix.VerifiedRoutes  # Add this line
  import StudentPerformanceAnalyticsWeb.CoreComponents  # Import core components
  import StudentPerformanceAnalyticsWeb.FormComponents
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">Register</.header>

      <.simple_form for={@form} id="registration_form" phx-submit="register">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <.input field={@form[:password]} type="password" placeholder="Password" required />
        <:actions>
          <.button phx-disable-with="Registering...">Register</.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={Routes.user_session_path(@socket, :new)}>Log in</.link>
        | <.link href={Routes.user_forgot_password_path(@socket, :new)}>Forgot Password?</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("register", %{"user" => user_params}, socket) do
    # Registration logic
    {:noreply, socket |> put_flash(:info, "Registration successful. Please log in.")}
  end
end
