require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:message) { FactoryGirl.create(:message) }
  let(:group) { FactoryGirl.create(:group, messages:[message]) }
  let(:user) { FactoryGirl.create(:user)}

  describe 'GET #index' do
    context 'if the user log in' do
      before do
        login_user user
      end

      it "assigns the requested message to @message" do
        get :index, {group_id: group.id}
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns the requested group to @group" do
        get :index, {group_id: group.id}
        expect(assigns(:group)).to eq group
      end

      it "assigns the requested messages to @messages" do
        get :index, {group_id: group.id}
        expect(assigns(:messages)).to eq group.messages
      end

      it "renders the :index template" do
        get :index, {group_id: group.id}
        expect(response).to render_template :index
      end
    end

    context 'if the user does not log in' do
      it "renders the new_user_session_path template" do
        get :index, {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
