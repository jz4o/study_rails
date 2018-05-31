class FeatureActiveRecord::ParentsController < ApplicationController
  before_action :set_feature_active_record_parent, only: [:show, :edit, :update, :destroy]

  # GET /feature_active_record/parents
  # GET /feature_active_record/parents.json
  def index
    @feature_active_record_parents = FeatureActiveRecord::Parent.all
  end

  # GET /feature_active_record/parents/1
  # GET /feature_active_record/parents/1.json
  def show
  end

  # GET /feature_active_record/parents/new
  def new
    @feature_active_record_parent = FeatureActiveRecord::Parent.new
  end

  # GET /feature_active_record/parents/1/edit
  def edit
  end

  # POST /feature_active_record/parents
  # POST /feature_active_record/parents.json
  def create
    @feature_active_record_parent = FeatureActiveRecord::Parent.new(feature_active_record_parent_params)

    respond_to do |format|
      if @feature_active_record_parent.save
        format.html { redirect_to @feature_active_record_parent, notice: 'Parent was successfully created.' }
        format.json { render :show, status: :created, location: @feature_active_record_parent }
      else
        format.html { render :new }
        format.json { render json: @feature_active_record_parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feature_active_record/parents/1
  # PATCH/PUT /feature_active_record/parents/1.json
  def update
    respond_to do |format|
      if @feature_active_record_parent.update(feature_active_record_parent_params)
        format.html { redirect_to @feature_active_record_parent, notice: 'Parent was successfully updated.' }
        format.json { render :show, status: :ok, location: @feature_active_record_parent }
      else
        format.html { render :edit }
        format.json { render json: @feature_active_record_parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feature_active_record/parents/1
  # DELETE /feature_active_record/parents/1.json
  def destroy
    @feature_active_record_parent.destroy
    respond_to do |format|
      format.html { redirect_to feature_active_record_parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feature_active_record_parent
      @feature_active_record_parent = FeatureActiveRecord::Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feature_active_record_parent_params
      params.require(:feature_active_record_parent).permit(:name)
    end
end
