class ApplicationController < ActionController::Base
  def return_to_root(message = nil)
    flash[:notice] = message if message
    redirect_to root_path
    # Aquí podrían añadirse mensajes de error, etc.
  end
end
