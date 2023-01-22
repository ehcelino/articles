module UsersHelper

  def user_links
    result = "".html_safe
    if current_user.username == "Visitante"
      result << link_to("Entrar", login_path)
      result << link_to("Inscrição", signup_path)
    else
      result << link_to("Bem vindo, #{current_user.username}", user_path(current_user))
      result << link_to("Sair", logout_path)
    end
    result
  end


end
