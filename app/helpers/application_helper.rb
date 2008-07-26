module ApplicationHelper
  def title(page_title)
    content_for(:title) { "#{page_title} - Address Watcher" }
  end
end