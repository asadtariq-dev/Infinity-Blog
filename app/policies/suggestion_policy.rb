# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def destroy?
    user == record.post.author || user == record.author
  end

  def edit?
    user == record.author
  end

  def update?
    edit?
  end
end
