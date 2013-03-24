module ApplicationHelper

  def anchor_tag(label)
    return content_tag(:a, raw('&nbsp;'), {:name => label, :class => 'anchor_tag'})
  end
end
