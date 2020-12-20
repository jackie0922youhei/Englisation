require 'rails_helper'

RSpec.describe "customerAuthentications", type: :request do
  let(:customer) { FactoryBot.create(:customer) }
  let(:customer_params) { attributes_for(:customer) }
  let(:invalid_customer_params) { attributes_for(:customer, username: "") }
  let(:invalid_customer_password_params) { attributes_for(:customer, password: "") }
  let(:invalid_customer_last_name_params) { attributes_for(:customer, last_name: "") }
  let(:invalid_customer_first_name_params) { attributes_for(:customer, first_name: "") }
  let(:invalid_customer_email_params) { attributes_for(:customer, email: "") }

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: customer_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post customer_registration_path, params: { customer: customer_params }
        end.to change(Customer, :count).by(1)
      end

      it 'リダイレクトされること' do
        post customer_registration_path, params: { customer: customer_params }
        expect(response).to redirect_to posts_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_params }
        end.to_not change(Customer, :count)
      end

      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_password_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_password_params }
        end.to_not change(Customer, :count)
      end

      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_last_name_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_last_name_params }
        end.to_not change(Customer, :count)
      end

      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_first_name_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_first_name_params }
        end.to_not change(Customer, :count)
      end

      it 'リクエストが成功すること' do
        post customer_registration_path, params: { customer: invalid_customer_email_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post customer_registration_path, params: { customer: invalid_customer_email_params }
        end.to_not change(Customer, :count)
      end
    end
  end
end