# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def destroy?
    user == record.author || user.moderator? || user.admin?
  end
end
