module ProfilesHelper

  def tab_link(tab, url,icon=nil)
    if icon
      icon = content_tag(:i, '', class: icon)
    else
      icon = ""
    end
    a = link_to(icon.html_safe+t("controllers.profiles.tabs.#{tab}"), url)
    content_tag :li, a, class: tab == @current_tab ? "active" : nil
  end

end
