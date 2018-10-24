require 'rails_helper'

RSpec.describe FeatureActiveRecord::ParentsController, type: :controller do
  before { allow(controller).to receive(:logged_in?).and_return(true) }

  let(:parent) { FactoryBot.create :feature_active_record_parent }

  let(:parent_with_children) do
    FactoryBot.create :feature_active_record_parent_with_children,
                      has_many_children_size: has_many_children_size
  end
  let(:has_many_children_size) { 10 }

  let(:parents) { FactoryBot.create_list :feature_active_record_parent, parents_size }
  let(:parents_size) { 5 }

  let(:parent_attributes) { FactoryBot.attributes_for :feature_active_record_parent }
  let(:has_one_child_attributes) { FactoryBot.attributes_for :feature_active_record_has_one_child }
  let(:has_many_child_attributes) { FactoryBot.attributes_for :feature_active_record_has_many_child }

  describe 'GET #index' do
    before { parents }

    let(:get_request) { get :index }

    describe 'response' do
      subject { get_request }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :index }
    end

    describe 'assigns' do
      subject { assigns[:feature_active_record_parents] }
      before { get_request }
      it { is_expected.to eq parents }
      it { expect(subject.size).to eq parents_size }
    end
  end

  describe 'GET #show' do
    let(:get_request) { get :show, params: { id: target } }

    context 'when specific exist record' do
      let(:target) { parent }

      describe 'response' do
        subject { get_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :show }
      end

      describe 'assigns' do
        subject { assigns[:feature_active_record_parent] }
        before { get_request }
        it { is_expected.to eq parent }
      end
    end

    context 'when specific not exist record' do
      subject { proc { get_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    describe 'response' do
      subject { get :new }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :new }
    end

    describe 'assigns' do
      subject { assigns[:feature_active_record_parent] }
      before { get :new }
      it { is_expected.to be_a_new FeatureActiveRecord::Parent }
    end
  end

  describe 'GET #edit' do
    let(:get_request) { get :edit, params: { id: target } }

    context 'when specific exist record' do
      let(:target) { parent }

      describe 'response' do
        subject { get_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :edit }
      end

      describe 'assigns' do
        subject { assigns[:feature_active_record_parent] }
        before { get_request }
        it { is_expected.to eq parent }
      end
    end

    context 'when specific not exist record' do
      subject { proc { get_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'POST #create' do
    let(:post_request) { post :create, params: parameters }
    let(:parameters) do
      {
        feature_active_record_parent:
          parent_attributes.merge(
            has_one_child_attributes: has_one_child_attributes
          ).merge(
            has_many_children_attributes: [has_many_child_attributes]
          )
      }
    end

    context 'when success with save' do
      before { allow_any_instance_of(FeatureActiveRecord::Parent).to receive(:valid?).and_return(true) }

      context 'response' do
        subject { post_request }
        it { is_expected.to have_http_status :found }
        it { is_expected.to redirect_to assigns[:feature_active_record_parent] }
      end

      context 'database' do
        subject { proc { post_request } }
        it { is_expected.to change(FeatureActiveRecord::Parent, :count) }
        it { is_expected.to change(FeatureActiveRecord::HasOneChild, :count) }
        it { is_expected.to change(FeatureActiveRecord::HasManyChild, :count) }
      end
    end

    context 'when failure with save' do
      before { allow_any_instance_of(FeatureActiveRecord::Parent).to receive(:valid?).and_return(false) }

      context 'response' do
        subject { post_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :new }
      end

      context 'database' do
        subject { proc { post_request } }
        it { is_expected.to_not change(FeatureActiveRecord::Parent, :count) }
        it { is_expected.to_not change(FeatureActiveRecord::HasOneChild, :count) }
        it { is_expected.to_not change(FeatureActiveRecord::HasManyChild, :count) }
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:patch_request) { patch :update, params: parameters }
    let(:parameters) do
      {
        id: target,
        feature_active_record_parent: parent_update_attributes.merge(
          has_one_child_attributes: has_one_child_update_attributes.merge(
            id: has_one_target,
            _destroy: destroy
          ),
          has_many_children_attributes: [
            has_many_child_update_attributes.merge(
              id: has_many_target,
              _destroy: destroy
            )
          ]
        )
      }
    end
    let(:parent_update_attributes) { { name: 'updated_name' } }
    let(:has_one_child_update_attributes) { { name: 'updated_name' } }
    let(:has_many_child_update_attributes) { { name: 'updated_name' } }

    context 'when specific exist record' do
      before { parent_with_children }
      let(:target) { parent_with_children.id }
      let(:has_one_target) { parent_with_children.has_one_child.id }
      let(:has_many_target) { parent_with_children.has_many_children.first.id }
      let(:destroy) { 0 }

      context 'when success with update' do
        before { allow_any_instance_of(FeatureActiveRecord::Parent).to receive(:valid?).and_return(true) }

        describe 'response' do
          subject { patch_request }
          it { is_expected.to have_http_status :found }
          it { is_expected.to redirect_to assigns[:feature_active_record_parent] }
        end

        describe 'database' do
          subject { FeatureActiveRecord::Parent.find(parent_with_children.id) }
          before { patch_request }
          it { is_expected.to have_attributes parent_update_attributes }
        end

        context 'when update with children' do
          before { patch_request }

          describe 'database' do
            describe 'has one child' do
              subject { FeatureActiveRecord::HasOneChild.find(parent_with_children.has_one_child.id) }
              it { is_expected.to have_attributes has_one_child_update_attributes }
            end

            describe 'has many children' do
              subject { FeatureActiveRecord::HasManyChild.find(parent_with_children.has_many_children.first.id) }
              it { is_expected.to have_attributes has_many_child_update_attributes }
            end
          end
        end

        context 'when destroy children' do
          let(:destroy) { 1 }

          describe 'database' do
            subject { proc { patch_request } }

            it { is_expected.to change(FeatureActiveRecord::HasOneChild, :count).by(-1) }
            it { is_expected.to change(FeatureActiveRecord::HasManyChild, :count).by(-1) }
          end
        end
      end

      context 'when failure with update' do
        before { allow_any_instance_of(FeatureActiveRecord::Parent).to receive(:valid?).and_return(false) }

        describe 'response' do
          subject { patch_request }
          it { is_expected.to have_http_status :ok }
          it { is_expected.to render_template :edit }
        end

        describe 'database' do
          subject { proc { patch_request } }
          it { is_expected.to_not change(parent_with_children, :attributes) }
          it { is_expected.to_not change(parent_with_children.has_one_child, :attributes) }
          it { is_expected.to_not change(parent_with_children.has_many_children.first, :attributes) }
        end
      end
    end

    context 'when specific not exist record' do
      subject { proc { patch :update, params: { id: -1 } } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: target } }

    context 'when specific exist record' do
      before { parent_with_children }
      let(:target) { parent_with_children }

      describe 'response' do
        subject { delete_request }
        it { is_expected.to have_http_status :found }
        it { is_expected.to redirect_to feature_active_record_parents_url }
      end

      describe 'database' do
        subject { proc { delete_request } }
        it { is_expected.to change(FeatureActiveRecord::Parent, :count).by(-1) }
        it { is_expected.to change(FeatureActiveRecord::HasOneChild, :count).by(-1) }
        it { is_expected.to change(FeatureActiveRecord::HasManyChild, :count).by(-has_many_children_size) }
      end
    end

    context 'when specific not exist record' do
      subject { proc { delete_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
