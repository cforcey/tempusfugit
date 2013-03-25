module ApplicationHelper

  def anchor_tag(label)
    return content_tag(:a, raw('&nbsp;'), {:name => label, :class => 'anchor_tag'})
  end

  def icon_tag(icon_label)
    return content_tag(:i, nil, class: icon_label)
  end

  def boolean_icon(value)
    return value ?  icon_tag('icon-check') : icon_tag('icon-check-empty')
  end

  # returns just the time if today, or the date if earlier
  def friendly_timestamp(timestamp)
   if timestamp.is_a? Time
      if timestamp.today?
        return I18n.localize(timestamp, :format => :time_only)
      else
        return I18n.localize(timestamp, :format => :short)
      end
    end
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, friendly_timestamp(time), options.merge(:datetime => time.getutc.iso8601)) if time
  end

end
