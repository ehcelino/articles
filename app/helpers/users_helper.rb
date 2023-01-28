module UsersHelper

  def user_links
    result = "".html_safe
    if current_user.username == "Visitante"
      result << link_to(content_tag(:i, " ", class:"fa-solid fa-arrow-up ico-blue") + " Entrar", login_path)
      result << link_to(content_tag(:i, " ", class:"fa-solid fa-pen-to-square ico-blue") + " Inscrição", signup_path)
    else
      result << link_to(content_tag(:i, " ", class:"fa-solid fa-user ico-blue") + " Bem vindo, #{current_user.username}", user_path(current_user))
      if current_user.admin?
        result << link_to("Dashboard", admin_dashboard_index_path)
        result << link_to("Configurações", admin_settings_path)
      end
      result << link_to(content_tag(:i, " ", class:"fa-solid fa-pen-nib ico-blue") + " Novo artigo", new_article_path)
      result << link_to(content_tag(:i, " ", class:"fa-solid fa-arrow-right ico-blue") + " Sair", logout_path)
    end
    result
  end


end
