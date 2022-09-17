# frozen_string_literal: true

module ReportsHelper
  def current_report(reportable)
    Report.find_by(reportable: reportable)
  end

  def report_count(reportable)
    reportable.reports.count
  end
end
