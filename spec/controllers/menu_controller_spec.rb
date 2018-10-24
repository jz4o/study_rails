require 'rails_helper'

RSpec.describe MenuController, type: :controller do
  before { allow(controller).to receive(:logged_in?).and_return(true) }

  describe 'GET #index' do
    describe 'response' do
      subject { get :index }
      it { is_expected.to have_http_status :ok }
      it { is_expected.to render_template :index }
    end

    describe 'assigns' do
      subject { assigns[:menu_items] }
      before { get :index }
      it { is_expected.to eq Menu.items }
    end
  end

  describe 'GET #show' do
    let(:get_request) { get :show, params: { param: :index, index: target } }

    context 'when specific exist menu index' do
      let(:target) { 0 }

      describe 'response' do
        subject { get_request }
        it { is_expected.to have_http_status :ok }
        it { is_expected.to render_template :show }
      end

      describe 'assigns' do
        subject { assigns[:menu_item] }
        before { get_request }
        it { is_expected.to eq Menu.items.first }
      end
    end

    context 'when specific not exist menu index' do
      render_views
      subject { proc { get_request } }
      let(:target) { Menu.items.size }
      it { is_expected.to raise_error ActionView::Template::Error }
    end
  end
end
