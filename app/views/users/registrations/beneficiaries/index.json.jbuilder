# frozen_string_literal: true

json.array! @beneficiaries, partial: 'beneficiaries/beneficiary', as: :beneficiary
