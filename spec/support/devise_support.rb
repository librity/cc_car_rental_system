# frozen_string_literal: true

module DeviseSupport
  def log_user_in! user = create(:user)
    login_as user, scope: :user
    user
  end
end
