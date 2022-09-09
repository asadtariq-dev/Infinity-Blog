# frozen_string_literal: true

class ReportsController < ApplicationController
  def create
    @report = current_author.reports.new(report_params)

    flash[:notice] = if @report.save
                       'Report Submitted'
                     else
                       @report.errors.full_messages.to_sentence
                     end
    redirect_back(fallback_location: posts_url)
  end

  def destroy
    @report = current_author.reports.find(params[:id])

    flash[:notice] = if @report.destroy
                       'Report Cancelled'
                     else
                       @report.errors.full_messages.to_sentence
                     end
    redirect_back(fallback_location: posts_url)
  end

  private

  def report_params
    params.require(:report).permit(:reportable_id, :reportable_type)
  end
end
