module Api::V1::Public
  class JobsController < ApplicationController
    before_action :set_job, only: [:show]

    def index
      if params[:query].present?
        @jobs = Job.search(params[:query])
      else
        @jobs = Job.where(status: 'active')
      end
      render json: @jobs
    end

    def show
      render json: @job
    end

    private

    def set_job
      @job = Job.find(params[:id])
    end
  end
end
