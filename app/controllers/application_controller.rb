# frozen_string_literal: true

require 'pagy/extras/bootstrap'

class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :set_paper_trail_whodunnit

  before_action :finish_registration

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { render nothing: true, status: :not_found }
    end
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
  def finish_registration
    return if current_user.blank? || devise_controller?

    case current_user.state
    when 'initialized'
      return if controller_name == 'account_types'

      redirect_to edit_users_registrations_account_types_path
    when 'type_confirmed'
      return if controller_name.in?(%w[food_providers beneficiaries])

      redirect_to new_users_registrations_food_providers_path if current_user.account_food_provider?
      redirect_to new_users_registrations_beneficiaries_path if current_user.account_beneficiary?
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:fullname, :email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password) }
  end

  private

  def require_food_provider!
    return if current_user&.food_provider.present?

    redirect_to root_path, alert: t('common.access_denied')
  end

  def require_beneficiary!
    return if current_user&.beneficiary.present?

    redirect_to root_path, alert: t('common.access_denied')
  end
end
