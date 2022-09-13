# frozen_string_literal: true

class SuggestionPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def index?
    user == record[0].author
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
