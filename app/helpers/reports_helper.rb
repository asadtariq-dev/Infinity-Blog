# frozen_string_literal: true

module ReportsHelper
  def current_report(reportable)
    Report.find_by(reportable: reportable)
  end

  def report_count(reportable)
    reportable.reports.count
  end

  def delete_post_reports(post_id)
    Post.find(post_id).reports.destroy_all
  end
end
