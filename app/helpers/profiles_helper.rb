module ProfilesHelper

  def tab_link(tab)
    a = link_to(t("controllers.profiles.tabs.#{tab}"), profile_page_path(screen_name: @user.screen_name, tab: tab))
    content_tag :li, a, class: tab == @current_tab ? "active" : nil
  end

end
