defmodule StandardDataWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use StandardDataWeb, :controller` and
  `use StandardDataWeb, :live_view`.
  """
  use StandardDataWeb, :html
  use Phoenix.Component

  embed_templates "layouts/*"

  def menu(assigns) do
    ~H"""
    <aside class="w-64 bg-indigo-700 text-white flex-shrink-0 p-6">
      <h2 class="text-2xl font-bold mb-8">Menu</h2>
      <nav>
        <ul class="space-y-4">
          <li>
            <a href="#reports" class="block py-2 px-4 rounded hover:bg-indigo-600">
              Reports
            </a>
          </li>
          <li>
            <a href="#assessments" class="block py-2 px-4 rounded hover:bg-indigo-600">
              Assessments
            </a>
          </li>
          <li>
            <a href="#configure" class="block py-2 px-4 rounded hover:bg-indigo-600">
              Configure
            </a>
          </li>
        </ul>
      </nav>
    </aside>
    """
  end
end
