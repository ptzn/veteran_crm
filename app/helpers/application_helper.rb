module ApplicationHelper
  def render_menu_items
    safe_join(menu_items.map do |item|
      content_tag :li, class: 'nav-item' do
        css_class = 'nav-link'
        css_class << ' active' if request.path == item[:path]
        link_to item[:title], item[:path], class: css_class
      end
    end)
  end

  private

  def menu_items
    [
      {title: 'Dashboard', path: dashboard_path},
      {title: 'Posts', path: posts_path},
    ]
  end
end
