module ProfilesHelper

  def tab_link(tab, url)
    a = link_to(t("controllers.profiles.tabs.#{tab}"), url)
    content_tag :li, a, class: tab == @current_tab ? "active" : nil
  end

end
