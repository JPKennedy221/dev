defmodule StudentPerformanceAnalyticsWeb.UserLoginLive do
  use StudentPerformanceAnalyticsWeb, :live_view
  import Phoenix.VerifiedRoutes  # Add this line
  import StudentPerformanceAnalyticsWeb.CoreComponents  # Import core components
  import StudentPerformanceAnalyticsWeb.FormComponents
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">Log In</.header>

      <.simple_form for={@form} id="login_form" phx-submit="log_in">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <.input field={@form[:password]} type="password" placeholder="Password" required />
        <:actions>
          <.button phx-disable-with="Logging in...">Log in</.button>
        </:actions>
      </.simple_form>

      <p class="text-center mt-4">
        <.link href={Routes.user_registration_path(@socket, :new)}>Register</.link>
        | <.link href={Routes.user_forgot_password_path(@socket, :new)}>Forgot Password?</.link>
      </p>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("log_in", %{"user" => user_params}, socket) do
    # Authentication logic to handle login.
    {:noreply, socket |> put_flash(:info, "Logged in successfully.")}
  end
end
