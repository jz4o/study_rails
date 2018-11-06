require 'rails_helper'

RSpec.describe FeatureCarrierWave::UsersController, type: :controller do
  before { allow(controller).to receive(:logged_in?).and_return(true) }

  let(:user) { FactoryBot.create :feature_carrier_wave_user }
  let(:users) { FactoryBot.create_list :feature_carrier_wave_user, users_size }
  let(:users_size) { 5 }

  let(:user_attributes) { FactoryBot.attributes_for :feature_carrier_wave_user }

  let(:upload_folder) { Rails.root.join('public', "#{Rails.env}_uploads", 'feature_carrier_wave') }
  let(:uploaded_file_paths) { Dir.glob(upload_folder.join('**', '*')).select { |file| File.file? file } }

  let(:avatar_parameter) do
    {
      avatar: fixture_file_upload(
        ['feature_carrier_wave', avatar_parameter_file_name].join('/'),
        'image/png'
      )
    }
  end
  let(:avatar_parameter_file_name) { 'avatar_red.png' }

  describe 'GET #index' do
    before { users }

    let(:get_request) { get :index }

    describe 'response' do
      subject { get_request }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :index }
    end

    describe 'assigns' do
      subject { assigns[:feature_carrier_wave_users] }
      before { get_request }
      it { is_expected.to eq users }
      it { expect(subject.size).to eq users_size }
    end
  end

  describe 'GET #show' do
    let(:get_request) { get :show, params: { id: target } }

    context 'when specific exist record' do
      let(:target) { user }

      describe 'response' do
        subject { get_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :show }
      end

      describe 'assigns' do
        subject { assigns[:feature_carrier_wave_user] }
        before { get_request }
        it { is_expected.to eq user }
      end
    end

    context 'when specific not exist record' do
      subject { proc { get_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    let(:get_request) { get :new }

    describe 'response' do
      subject { get_request }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :new }
    end

    describe 'assigns' do
      subject { assigns[:feature_carrier_wave_user] }
      before { get_request }
      it { is_expected.to be_a_new FeatureCarrierWave::User }
    end
  end

  describe 'GET #edit' do
    let(:get_request) { get :edit, params: { id: target } }
    context 'when specific exist record' do
      let(:target) { user }

      describe 'response' do
        subject { get_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :edit }
      end

      describe 'assigns' do
        subject { assigns[:feature_carrier_wave_user] }
        before { get_request }
        it { is_expected.to eq user }
      end
    end

    context 'when specific not exist record' do
      subject { proc { get_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'POST #confirm' do
    before do
      allow_any_instance_of(FeatureCarrierWave::User).to receive(:avatar).and_return(avatar)
      allow(avatar).to receive(:cache!)
    end

    let(:post_request) { post :confirm, params: parameters }
    let(:parameters) { { feature_carrier_wave_user: user_attributes } }
    let(:avatar) { user.avatar }

    describe 'response' do
      subject { post_request }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :confirm }
    end

    describe 'assigns' do
      subject { assigns[:feature_carrier_wave_user] }
      before { post_request }
      it { is_expected.to be_a_new FeatureCarrierWave::User }
    end

    describe 'file' do
      subject { avatar }

      context 'when making a request with file' do
        before { post_request }
        it { is_expected.to have_received(:cache!) }
      end

      context 'when making a request not with file' do
        before do
          parameters[:feature_carrier_wave_user].delete :avatar
          post_request
        end

        it { is_expected.to_not have_received(:cache!) }
      end
    end
  end

  describe 'POST #create' do
    let(:post_request) { post :create, params: parameters }
    let(:parameters) { { feature_carrier_wave_user: user_attributes } }

    context 'when success with save' do
      before { allow_any_instance_of(FeatureCarrierWave::User).to receive(:valid?).and_return(true) }

      context 'when via confirm' do
        before do
          build_user = FactoryBot.build :feature_carrier_wave_user
          build_user.avatar.cache!
          avatar_parameter = { cache: { avatar: build_user.avatar.cache_name } }
          parameters.merge! avatar_parameter
        end

        describe 'response' do
          subject { post_request }
          it { is_expected.to have_http_status :found }
          it { is_expected.to redirect_to assigns[:feature_carrier_wave_user] }
        end

        describe 'database' do
          subject { proc { post_request } }
          it { is_expected.to change(FeatureCarrierWave::User, :count) }
        end

        describe 'file' do
          subject { uploaded_file_paths }
          before { post_request }
          it { is_expected.to be_any }
        end
      end

      context 'when not via confirm' do
        before { parameters[:feature_carrier_wave_user].merge! avatar_parameter }

        describe 'response' do
          subject { post_request }
          it { is_expected.to have_http_status :found }
          it { is_expected.to redirect_to assigns[:feature_carrier_wave_user] }
        end

        describe 'database' do
          subject { proc { post_request } }
          it { is_expected.to change(FeatureCarrierWave::User, :count) }
        end

        describe 'file' do
          subject { uploaded_file_paths }
          before { post_request }
          it { is_expected.to be_any }
        end
      end
    end

    context 'when failure with save' do
      before { allow_any_instance_of(FeatureCarrierWave::User).to receive(:valid?).and_return(false) }

      describe 'response' do
        subject { post_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :new }
      end

      describe 'database' do
        subject { proc { post_request } }
        it { is_expected.to_not change(FeatureCarrierWave::User, :count) }
      end

      describe 'file' do
        context 'when via confirm' do
          let(:parameters) { { feature_carrier_wave_user: user_attributes } }

          subject { uploaded_file_paths }
          before { post_request }
          it { is_expected.to be_empty }
        end

        context 'when not via confirm' do
          subject { uploaded_file_paths }
          before { post_request }
          it { is_expected.to be_empty }
        end
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:patch_request) { patch :update, params: parameters }
    let(:parameters) do
      {
        id:                        target,
        feature_carrier_wave_user: user_update_attributes.merge(avatar_parameter)
      }
    end
    let(:user_update_attributes) { { name: 'updated_name' } }

    context 'when specific exist record' do
      before { user }
      let(:target) { user }

      context 'when success with update' do
        before { allow_any_instance_of(FeatureCarrierWave::User).to receive(:valid?).and_return(true) }

        describe 'response' do
          subject { patch_request }
          it { is_expected.to have_http_status :found }
          it { is_expected.to redirect_to assigns[:feature_carrier_wave_user] }
        end

        describe 'database' do
          subject { FeatureCarrierWave::User.find(user.id) }
          before { patch_request }
          it { is_expected.to have_attributes user_update_attributes }
        end

        describe 'file' do
          subject { uploaded_file_paths.select { |path| path.match("\/#{avatar_parameter_file_name}$") } }
          before { patch_request }
          it { is_expected.to be_any }
        end
      end

      context 'when failure with update' do
        before { allow_any_instance_of(FeatureCarrierWave::User).to receive(:valid?).and_return(false) }

        describe 'response' do
          subject { patch_request }
          it { is_expected.to have_http_status :ok }
          it { is_expected.to render_template :edit }
        end

        describe 'database' do
          subject { proc { patch_request } }
          it { is_expected.to_not change(user, :attributes) }
        end

        describe 'file' do
          subject { uploaded_file_paths.select { |path| path.match("\/#{avatar_parameter_file_name}$") } }
          before { patch_request }
          it { is_expected.to be_empty }
        end
      end
    end

    context 'when specific not exist record' do
      subject { proc { patch_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'DELETE #destroy' do
    let(:delete_request) { delete :destroy, params: { id: target } }
    context 'when specific exist record' do
      before { user }
      let(:target) { user }

      describe 'response' do
        subject { delete_request }
        it { is_expected.to have_http_status :found }
        it { is_expected.to redirect_to feature_carrier_wave_users_url }
      end

      describe 'database' do
        subject { proc { delete_request } }
        it { is_expected.to change(FeatureCarrierWave::User, :count).by(-1) }
      end

      describe 'file' do
        subject { uploaded_file_paths }
        before { delete_request }
        it { is_expected.to be_empty }
      end
    end

    context 'when specific not exist record' do
      subject { proc { delete_request } }
      let(:target) { -1 }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
