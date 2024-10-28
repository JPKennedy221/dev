defmodule StudentPerformanceAnalyticsWeb.StudentController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Students
  alias StudentPerformanceAnalytics.Classes

  def index(conn, _params) do
    students = Students.list_students()
    render(conn, :index, students: students)
  end

  def new(conn, _params) do
    classes = Classes.list_active_classes()
    changeset = Students.change_student(%Students.Student{})
    render(conn, :new, changeset: changeset, classes: classes)
  end

  def create(conn, %{"student" => student_params}) do
    case Students.create_student(student_params) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, changeset} ->
        classes = Classes.list_active_classes()
        render(conn, :new, changeset: changeset, classes: classes)
    end
  end

  def edit(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    classes = Classes.list_active_classes()
    changeset = Students.change_student(student)
    render(conn, :edit, student: student, changeset: changeset, classes: classes)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Students.get_student!(id)

    case Students.update_student(student, student_params) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, changeset} ->
        classes = Classes.list_active_classes()
        render(conn, :edit, student: student, changeset: changeset, classes: classes)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    {:ok, _student} = Students.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end
end
