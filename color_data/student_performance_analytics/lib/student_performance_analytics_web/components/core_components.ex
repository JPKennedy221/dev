defmodule StudentPerformanceAnalyticsWeb.CoreComponents do
  use Phoenix.Component

  def button(assigns) do
    ~H"""
    <button class={"btn #{@class}"}><%= @label %></button>
    """
  end

  def text_input(assigns) do
    ~H"""
    <input type="text" class="form-input" value={@value} name={@name} />
    """
  end

  def select(assigns) do
    ~H"""
    <select class="form-select" name={@name}>
      <%= for {label, value} <- @options do %>
        <option value={value}><%= label %></option>
      <% end %>
    </select>
    """
  end
end
