defmodule StudentPerformanceAnalyticsWeb do
  @moduledoc """
  The entry point for defining your web interface, such as
  controllers, components, channels, and so on.
  """

  # Use this for controllers
  def controller do
    quote do
      use Phoenix.Controller, namespace: StudentPerformanceAnalyticsWeb
      import Plug.Conn
      import StudentPerformanceAnalyticsWeb.Gettext
      alias StudentPerformanceAnalyticsWeb.Router.Helpers, as: Routes
    end
  end

  # Use this for HTML components
  def html do
    quote do
      use Phoenix.Component
      import Phoenix.HTML
      import Phoenix.HTML.Form
      import Phoenix.HTML.Link
      import Phoenix.Component

      # Import core components
      import StudentPerformanceAnalyticsWeb.CoreComponents
      import StudentPerformanceAnalyticsWeb.FormComponent

      # Import route helpers
      alias StudentPerformanceAnalyticsWeb.Router.Helpers, as: Routes

      # Additional imports for custom functions
      import StudentPerformanceAnalyticsWeb.ErrorHelpers
    end
  end

  # Use this for LiveView and LiveComponents
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {StudentPerformanceAnalyticsWeb.Layouts, :app_layout}

      import Phoenix.LiveView.Helpers
      import StudentPerformanceAnalyticsWeb.CoreComponents
      alias StudentPerformanceAnalyticsWeb.Router.Helpers, as: Routes
      import StudentPerformanceAnalyticsWeb.Gettext
    end
  end

  # Use this for LiveComponents
  def live_component do
    quote do
      use Phoenix.LiveComponent
      import Phoenix.LiveView.Helpers
      import StudentPerformanceAnalyticsWeb.CoreComponents
      alias StudentPerformanceAnalyticsWeb.Router.Helpers, as: Routes
      import StudentPerformanceAnalyticsWeb.Gettext
    end
  end

  # Use this for routing
  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  # Use this for channels
  def channel do
    quote do
      use Phoenix.Channel
      import StudentPerformanceAnalyticsWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/component/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
