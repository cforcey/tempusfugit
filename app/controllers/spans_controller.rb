class SpansController < ApplicationController

  before_filter :authenticate_user!

  before_action :set_span, only: [:show, :edit, :update, :destroy]
  before_action :set_spans, :set_projects, only: [:index, :show, :edit, :update, :new, :create]

  # GET /spans
  # GET /spans.json
  def index
    initialize_span(@projects)
  end

  # GET /spans/1
  # GET /spans/1.json
  def show
  end

  # GET /spans/new
  def new
    initialize_span(@projects)
  end

  # GET /spans/1/edit
  def edit
  end

  # POST /spans
  # POST /spans.json
  def create
    @span = Span.new(span_params)

    # map the span to the current user (putting this in the form would be insecure)
    @span.user = current_user
    respond_to do |format|
      if @span.save
        format.html { redirect_to spans_path, notice: 'Span was successfully created.' }
        format.json { render action: 'show', status: :created, location: @span }
      else
        format.html { render action: 'index' }
        format.json { render json: @span.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spans/1
  # PATCH/PUT /spans/1.json
  def update
    respond_to do |format|
      if @span.update(span_params)
        format.html { redirect_to spans_path, notice: 'Span was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @span.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spans/1
  # DELETE /spans/1.json
  def destroy
    @span.destroy
    respond_to do |format|
      format.html { redirect_to spans_url, :notice => 'Span was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_span
      # spans should always be scoped to the current user
      @span = current_user.spans.find(params[:id])
    end

    # because our create form is on the index page, index and new share the same setup
    def initialize_span(projects)
      # create a new one since we use an inline form
      @span = Span.new(:project_id => projects.try(:first).try(:id))
    end

    def set_projects
      @projects = current_user.projects.order_by_name
    end

    def set_spans
      @spans = current_user.spans.scoped.order_by_start_at
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def span_params
      params.require(:span).permit(:name, :description, :user_id, :project_id, :start_at, :end_at, :start_input, :end_input, :billable, :invoiced_at, :notes)
    end
end
