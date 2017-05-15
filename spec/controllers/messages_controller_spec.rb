require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:message) { FactoryGirl.create(:message) }
  let(:group) { FactoryGirl.create(:group, messages:[message]) }
  let(:user) { FactoryGirl.create(:user)}

  describe 'GET #index' do
    context 'if the user log in' do
      before do
        login_user user
        get :index, params: {group_id: group.id}
      end

      it "assigns the requested message to @message" do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns the requested group to @group" do
        expect(assigns(:group)).to eq group
      end

      it "assigns the requested messages to @messages" do
        expect(assigns(:messages)).to eq group.messages
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end

    context 'if the user does not log in' do
      it "renders the new_user_session_path template" do
        get :index, params: {group_id: group.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    context 'if the message is valid' do
       before do
        login_user user
        post :create, params: {group_id: group.id, message: attributes_for(:message)}
      end

      it "assigns the reqested message to @message" do
        expect{assigns(:message)}.to change(Message, :count).by(0)
      end

      it "is valid with a message" do
        expect(assigns(:message)).to be_valid
      end

      it "renders the :create template" do
        expect(response).to redirect_to group_messages_path
      end
    end

    context 'if the message is invalid' do
      before do
        login_user user
        post :create, params: {group_id: group.id, message: {body: ""}}
      end

      it "is invalid without a message" do
        expect(assigns(:message)).not_to be_valid
      end
    end
  end
end
