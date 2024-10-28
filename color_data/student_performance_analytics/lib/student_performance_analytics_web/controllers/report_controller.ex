defmodule StudentPerformanceAnalyticsWeb.ReportController do
  use StudentPerformanceAnalyticsWeb, :controller
  alias StudentPerformanceAnalytics.Assessments
  alias StudentPerformanceAnalytics.Classes

  # Display the comparison report based on selected class and assessment type
  def comparison_report(conn, %{"class_id" => class_id, "assessment_type_id" => assessment_type_id}) do
    class = Classes.get_class!(class_id)
    report_data = Assessments.get_comparison_report(class_id, assessment_type_id)

    render(conn, :comparison_report, class: class, report_data: report_data)
  end

  # Display performance slips for each student in a class
  def student_slips(conn, %{"class_id" => class_id}) do
    class = Classes.get_class!(class_id)
    slips = Assessments.get_student_slips(class_id)

    render(conn, :student_slips, class: class, slips: slips)
  end
end
