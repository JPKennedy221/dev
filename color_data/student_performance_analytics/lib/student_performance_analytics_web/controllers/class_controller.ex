defmodule StudentPerformanceAnalyticsWeb.ClassController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Classes
  alias StudentPerformanceAnalytics.Accounts

  def index(conn, _params) do
    classes = Classes.list_active_classes()
    render(conn, :index, classes: classes)
  end

  def new(conn, _params) do
    teachers = Accounts.list_teachers()
    changeset = Classes.change_class(%Classes.Class{})
    render(conn, :new, changeset: changeset, teachers: teachers)
  end

  def create(conn, %{"class" => class_params}) do
    case Classes.create_class(class_params) do
      {:ok, _class} ->
        conn
        |> put_flash(:info, "Class created successfully.")
        |> redirect(to: Routes.class_path(conn, :index))

      {:error, changeset} ->
        teachers = Accounts.list_teachers()
        render(conn, :new, changeset: changeset, teachers: teachers)
    end
  end

  def edit(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    teachers = Accounts.list_teachers()
    changeset = Classes.change_class(class)
    render(conn, :edit, class: class, changeset: changeset, teachers: teachers)
  end

  def update(conn, %{"id" => id, "class" => class_params}) do
    class = Classes.get_class!(id)

    case Classes.update_class(class, class_params) do
      {:ok, _class} ->
        conn
        |> put_flash(:info, "Class updated successfully.")
        |> redirect(to: Routes.class_path(conn, :index))

      {:error, changeset} ->
        teachers = Accounts.list_teachers()
        render(conn, :edit, class: class, changeset: changeset, teachers: teachers)
    end
  end

  def delete(conn, %{"id" => id}) do
    class = Classes.get_class!(id)
    {:ok, _class} = Classes.delete_class(class)

    conn
    |> put_flash(:info, "Class deleted successfully.")
    |> redirect(to: Routes.class_path(conn, :index))
  end
end
