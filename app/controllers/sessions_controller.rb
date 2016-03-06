class SessionsController < ApplicationController
  before_action :private_access!, only: [:destroy]
  before_action :public_access!, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, notice: 'Bienvenido a FlowOverstack'
    else
      flash[:error] = 'Email o contraseña inválidos.'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'Cerraste sesión correctamente.'
  end
end
