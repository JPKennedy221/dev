defmodule StudentPerformanceAnalyticsWeb.UserSettingsLive do
  use StudentPerformanceAnalyticsWeb, :live_view
  import Phoenix.VerifiedRoutes  # Add this line
  import StudentPerformanceAnalyticsWeb.CoreComponents  # Import core components
  import StudentPerformanceAnalyticsWeb.FormComponents
  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">Account Settings</.header>

      <.simple_form for={@form} id="settings_form" phx-submit="update_settings">
        <.input field={@form[:email]} type="email" placeholder="Email" required />
        <.input field={@form[:password]} type="password" placeholder="New Password" />
        <:actions>
          <.button phx-disable-with="Updating...">Update Settings</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("update_settings", %{"user" => user_params}, socket) do
    # Update settings logic
    {:noreply, socket |> put_flash(:info, "Account updated successfully.")}
  end
end
