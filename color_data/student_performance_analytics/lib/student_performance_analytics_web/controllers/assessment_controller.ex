defmodule StudentPerformanceAnalyticsWeb.AssessmentController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Assessments
  alias StudentPerformanceAnalytics.Classes
  alias StudentPerformanceAnalytics.Students
  alias StudentPerformanceAnalytics.Units

  def index(conn, _params) do
    assessments = Assessments.list_assessments()
    render(conn, :index, assessments: assessments)
  end

  def new(conn, _params) do
    classes = Classes.list_active_classes()
    students = Students.list_students()
    units = Units.list_units()
    assessment_types = Assessments.list_assessment_types()
    changeset = Assessments.change_assessment(%Assessments.Assessment{})
    render(conn, :new, changeset: changeset, classes: classes, students: students, units: units, assessment_types: assessment_types)
  end

  def create(conn, %{"assessment" => assessment_params}) do
    case Assessments.create_assessment(assessment_params) do
      {:ok, _assessment} ->
        conn
        |> put_flash(:info, "Assessment created successfully.")
        |> redirect(to: Routes.assessment_path(conn, :index))

      {:error, changeset} ->
        classes = Classes.list_active_classes()
        students = Students.list_students()
        units = Units.list_units()
        assessment_types = Assessments.list_assessment_types()
        render(conn, :new, changeset: changeset, classes: classes, students: students, units: units, assessment_types: assessment_types)
    end
  end

  def edit(conn, %{"id" => id}) do
    assessment = Assessments.get_assessment!(id)
    classes = Classes.list_active_classes()
    students = Students.list_students()
    units = Units.list_units()
    assessment_types = Assessments.list_assessment_types()
    changeset = Assessments.change_assessment(assessment)
    render(conn, :edit, assessment: assessment, changeset: changeset, classes: classes, students: students, units: units, assessment_types: assessment_types)
  end

  def update(conn, %{"id" => id, "assessment" => assessment_params}) do
    assessment = Assessments.get_assessment!(id)

    case Assessments.update_assessment(assessment, assessment_params) do
      {:ok, _assessment} ->
        conn
        |> put_flash(:info, "Assessment updated successfully.")
        |> redirect(to: Routes.assessment_path(conn, :index))

      {:error, changeset} ->
        classes = Classes.list_active_classes()
        students = Students.list_students()
        units = Units.list_units()
        assessment_types = Assessments.list_assessment_types()
        render(conn, :edit, assessment: assessment, changeset: changeset, classes: classes, students: students, units: units, assessment_types: assessment_types)
    end
  end

  def delete(conn, %{"id" => id}) do
    assessment = Assessments.get_assessment!(id)
    {:ok, _assessment} = Assessments.delete_assessment(assessment)

    conn
    |> put_flash(:info, "Assessment deleted successfully.")
    |> redirect(to: Routes.assessment_path(conn, :index))
  end
end
