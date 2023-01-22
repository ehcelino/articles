module UsersHelper

  def user_links
    result = "".html_safe
    if current_user.username == "Visitante"
      result << link_to("login", login_path)
      result << link_to("Signup", signup_path)
    else
      result << link_to("Bem vindo, #{current_user.username}", user_path(current_user))
      result << link_to("Logout", logout_path)
    end
    result
  end


end
