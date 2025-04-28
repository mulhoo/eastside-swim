class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from SomeAuthError, with: :user_not_authenticated

  private

  def user_not_authorized
    raise GraphQL::ExecutionError, "You are not authorized to perform this action."
  end

  def user_not_authenticated
    raise GraphQL::ExecutionError, "You must log in first."
  end
end
