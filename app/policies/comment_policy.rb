# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    user == record.author || user.moderator? || user.admin?
  end
end
