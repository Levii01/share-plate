# frozen_string_literal: true

json.extract! beneficiary, :id, :name, :user_id, :address, :description, :phone, :email, :state, :created_at,
              :updated_at
json.url beneficiary_url(beneficiary, format: :json)
