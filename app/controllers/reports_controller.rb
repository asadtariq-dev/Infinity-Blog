# frozen_string_literal: true

class ReportsController < ApplicationController
  def create
    @report = Report.new(report_params)
    if @report.save
      flash[:notice] = t('report_submitted')
    else
      flash[:alert] = @report.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @report = Report.find(params[:id])

    flash[:alert] = if @report.destroy
                      t('report_cancelled')
                    else
                      @report.errors.full_messages.to_sentence
                    end
    redirect_back(fallback_location: root_path)
  end

  private

  def report_params
    params.permit(:author_id, :reportable_id, :reportable_type)
  end
end
