# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def update?
    user == record.author
  end

  def destroy?
    update? || user.moderator? || user.admin?
  end

  def submit?
    update?
  end
end
