# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def destroy?
    user.id == record.post.author_id
  end

  def edit?
    user == record.author
  end

  def update?
    edit?
  end
end
