defmodule StudentPerformanceAnalyticsWeb.TeacherController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Accounts

  def index(conn, _params) do
    teachers = Accounts.list_teachers()
    render(conn, :index, teachers: teachers)
  end

  def new(conn, _params) do
    changeset = Accounts.change_teacher(%Accounts.Teacher{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"teacher" => teacher_params}) do
    case Accounts.create_teacher(teacher_params) do
      {:ok, _teacher} ->
        conn
        |> put_flash(:info, "Teacher created successfully.")
        |> redirect(to: Routes.teacher_path(conn, :index))

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    teacher = Accounts.get_teacher!(id)
    changeset = Accounts.change_teacher(teacher)
    render(conn, :edit, teacher: teacher, changeset: changeset)
  end

  def update(conn, %{"id" => id, "teacher" => teacher_params}) do
    teacher = Accounts.get_teacher!(id)

    case Accounts.update_teacher(teacher, teacher_params) do
      {:ok, _teacher} ->
        conn
        |> put_flash(:info, "Teacher updated successfully.")
        |> redirect(to: Routes.teacher_path(conn, :index))

      {:error, changeset} ->
        render(conn, :edit, teacher: teacher, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = Accounts.get_teacher!(id)
    {:ok, _teacher} = Accounts.delete_teacher(teacher)

    conn
    |> put_flash(:info, "Teacher deleted successfully.")
    |> redirect(to: Routes.teacher_path(conn, :index))
  end
end
