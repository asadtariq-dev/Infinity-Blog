# frozen_string_literal: true

class AuthorPolicy < ApplicationPolicy
  def show?
    user == record
  end

  def destroy?
    show? || user.admin?
  end

  def update?
    show?
  end

  def edit?
    show?
  end
end
