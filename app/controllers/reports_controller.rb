# frozen_string_literal: true

class ReportsController < ApplicationController
  def create
    @report = Report.new(report_params)
    flash[:notice] = if @report.save
                       'Report Submitted'
                     else
                       @report.errors.full_messages.to_sentence
                     end
    redirect_back(fallback_location: posts_url)
  end

  def destroy
    @report = Report.find(params[:id])

    flash[:notice] = if @report.destroy
                       'Report Cancelled'
                     else
                       @report.errors.full_messages.to_sentence
                     end
    redirect_back(fallback_location: posts_url)
  end

  private

  def report_params
    params.permit(:author_id, :reportable_id, :reportable_type)
  end
end
