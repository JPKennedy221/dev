defmodule StudentPerformanceAnalyticsWeb.Router do
  use StudentPerformanceAnalyticsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", StudentPerformanceAnalyticsWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/teachers", TeacherController
    resources "/classes", ClassController
    resources "/students", StudentController
    resources "/units", UnitController
    resources "/assessments", AssessmentController

    get "/reports/comparison", ReportController, :comparison_report
    get "/reports/student_slips", ReportController, :student_slips
  end
end
