# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def update?
    user == record.author
  end

  def destroy?
    user == record.author || user.moderator? || user.admin?
  end

  def submit?
    update?
  end
end
