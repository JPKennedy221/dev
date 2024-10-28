defmodule StudentPerformanceAnalyticsWeb.UnitController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Units

  def index(conn, _params) do
    units = Units.list_units()
    render(conn, :index, units: units)
  end

  def new(conn, _params) do
    changeset = Units.change_unit(%Units.Unit{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"unit" => unit_params}) do
    case Units.create_unit(unit_params) do
      {:ok, _unit} ->
        conn
        |> put_flash(:info, "Unit created successfully.")
        |> redirect(to: Routes.unit_path(conn, :index))

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    unit = Units.get_unit!(id)
    changeset = Units.change_unit(unit)
    render(conn, :edit, unit: unit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "unit" => unit_params}) do
    unit = Units.get_unit!(id)

    case Units.update_unit(unit, unit_params) do
      {:ok, _unit} ->
        conn
        |> put_flash(:info, "Unit updated successfully.")
        |> redirect(to: Routes.unit_path(conn, :index))

      {:error, changeset} ->
        render(conn, :edit, unit: unit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    unit = Units.get_unit!(id)
    {:ok, _unit} = Units.delete_unit(unit)

    conn
    |> put_flash(:info, "Unit deleted successfully.")
    |> redirect(to: Routes.unit_path(conn, :index))
  end
end
