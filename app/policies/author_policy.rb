# frozen_string_literal: true

class AuthorPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def show?
    user == record
  end

  def destroy?
    user == record || user.admin?
  end

  def update?
    show?
  end

  def edit?
    show?
  end
end
