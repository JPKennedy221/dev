defmodule StudentPerformanceAnalyticsWeb.ErrorHelpers do
  import Phoenix.HTML.Tag

  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag(:span, translate_error(error), class: "error")
    end
  end

  defp translate_error({msg, _opts}) do
    Phoenix.Naming.humanize(msg)
  end
end
