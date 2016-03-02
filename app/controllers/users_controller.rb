# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(user)
      redirect_to root_path, notice: 'Te has registrado con éxito.'
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
