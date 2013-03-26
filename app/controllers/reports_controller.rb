class ReportsController < ApplicationController



  def index
    # leave open the chance of having non-admin reports for timekeepers
    authorize! :admin_transaction, :admin_reports
    @users = User.timekeepers.order_by_sort_name.map { |u| [u.sort_name[0..30], u.id] }
    @projects = Project.order_by_name.map { |u| ["#{u.name[0..30]} (#{u.user.last[0..10]}...)", u.id] }
  end

  def project_summary
    authorize! :admin_transaction, :admin_reports
    @start_input = params[:start_input]
    @end_input = params[:end_input]
    @project_id = params[:project_id]

    if @start_input.present? && @end_input.present? && @project_id
      success = setup_project_summary_data(@start_input, @end_input, @project_id)
    else
      message = 'Missing start and end dates or project for report.'
      success = false
    end

    respond_to do |format|
      if success
        format.html
      else
        format.html { redirect_to reports_path, alert: 'Report data could not be generated. ' +  (message || '') }
      end
    end
  end

  def user_project_detail
    authorize! :admin_transaction, :admin_reports
    @start_input = params[:start_input]
    @end_input = params[:end_input]
    @user_id = params[:user_id]

    if @start_input.present? && @end_input.present? && @user_id
      success = setup_user_summary_data(@start_input, @end_input, @user_id)
    else
      message = 'Missing start and end dates or user for report.'
      success = false
    end

    respond_to do |format|
      if success
        format.html
      else
        format.html { redirect_to reports_path, alert: 'Report data could not be generated. ' + (message || '') }
      end
    end
  end

  private

  # TODO: Move some of this logic to a rails 4 concerns file
  def setup_project_summary_data(start_input, end_input, project_id)

    # convert the natural language to dates
    @start_date = Chronic.parse(start_input)
    @end_date = Chronic.parse(end_input)

    if @start_date.present? && @end_date.present?
      # grab the project
      @project = Project.where(:id => project_id).first

      @spans = @project.spans.occurs_between(@start_date, @end_date)
      # TODO: More efficient method using Postgres date math

      total_seconds = 0
      @spans.map do |s|
        total_seconds += s.duration_in_seconds || 0
      end
      @total_hours = (total_seconds / 3600).round unless total_seconds == 0
      @total_hours ||= 0

    end
    # send back a success boolean that all the prep went well
    return @project.present? && @spans.present? && @total_hours.present?

  end

  # TODO: Another rushed hack -- so much of this can be done in the DB but no time
  # right now to get it done properly.
  def setup_user_summary_data(start_input, end_input, user_id)

    # convert the natural language to dates
    @start_date = Chronic.parse(start_input)
    @end_date = Chronic.parse(end_input)

    if @start_date.present? && @end_date.present?
      # grab the project
      @user = User.where(:id => user_id).first

      spans = @user.spans.occurs_between(@start_date, @end_date)

      # TODO: More efficient method using Postgres date math
      total_seconds = 0
      @projects = {}
      spans.map do |s|
        @projects[s.project.name] ||= 0
        @projects[s.project.name] += s.duration_in_seconds
        total_seconds += s.duration_in_seconds
      end
      @total_hours = (total_seconds / 3600).round unless total_seconds == 0
      @total_hours ||= 0
    end
    # send back a success boolean that all the prep went well
    return @user.present? &&  @total_hours.present?  && @projects.present?

  end

end
