defmodule StudentPerformanceAnalyticsWeb.FormComponent do
  use Phoenix.Component
  import Phoenix.HTML.Form

  @doc """
  Renders a form with the provided changeset and action. Passes `f` (the form builder) to the inner block.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  slot :inner_block, required: true

  def form_component(assigns) do
    ~H"""
    <%= form_for @changeset, @action, fn f -> %>
      <%= render_slot(@inner_block, %{f: f}) %>
      <%= submit "Save" %>
    <% end %>
    """
  end
end
