require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  let(:user) { FactoryBot.create :user }

  describe 'GET #new' do
    subject { get :new }
    it { is_expected.to have_http_status :ok }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    context 'when success with authenticate' do
      subject { post :create, params: { user_session: { email: user.email, password: user.password } } }
      it { is_expected.to redirect_to root_url }
    end

    context 'when failure with authenticate' do
      subject { post :create, params: { user_session: { email: user.email, password: 'invalid_password' } } }
      it { is_expected.to render_template :new }
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }
    it { is_expected.to redirect_to login_url }
  end
end
