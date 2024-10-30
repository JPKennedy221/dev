defmodule StudentPerformanceAnalyticsWeb.Router do
  use StudentPerformanceAnalyticsWeb, :router

  import StudentPerformanceAnalyticsWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
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

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create

    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    delete "/users/log_out", UserSessionController, :delete
  end

  ## Authentication routes

  scope "/", StudentPerformanceAnalyticsWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{StudentPerformanceAnalyticsWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", StudentPerformanceAnalyticsWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{StudentPerformanceAnalyticsWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", StudentPerformanceAnalyticsWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{StudentPerformanceAnalyticsWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
