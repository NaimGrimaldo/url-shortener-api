# frozen_string_literal: true

class UsersController < ApplicationController
  include BasicCrudMethods

  private

  def model
    @model ||= User
  end

  def scope
    model.all.order(:created_at)
  end

  def object_params
    params.require(:user).permit(
      :name, :password, :last_name, :email, :id
    )
  end
end
