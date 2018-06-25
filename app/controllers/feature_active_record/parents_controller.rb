class FeatureActiveRecord::ParentsController < ApplicationController
  before_action :set_feature_active_record_parent, only: %i[show edit update destroy]

  def index
    @feature_active_record_parents = FeatureActiveRecord::Parent.all.includes(:has_one_child)
  end

  def show; end

  def new
    @feature_active_record_parent = FeatureActiveRecord::Parent.new
  end

  def edit; end

  def create
    @feature_active_record_parent = FeatureActiveRecord::Parent.new(feature_active_record_parent_params)

    if @feature_active_record_parent.save
      redirect_to @feature_active_record_parent, notice: 'Parent was successfully created.'
    else
      render :new
    end
  end

  def update
    if @feature_active_record_parent.update(feature_active_record_parent_params)
      redirect_to @feature_active_record_parent, notice: 'Parent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @feature_active_record_parent.destroy
    redirect_to feature_active_record_parents_url, notice: 'Parent was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feature_active_record_parent
    @feature_active_record_parent = FeatureActiveRecord::Parent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def feature_active_record_parent_params
    params.require(:feature_active_record_parent).permit(
      :name,
      has_one_child_attributes: %i[id name _destroy],
      has_many_children_attributes: %i[id name _destroy]
    )
  end
end
