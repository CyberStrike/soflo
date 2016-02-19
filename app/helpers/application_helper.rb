module ApplicationHelper

  def autoTabIndex
    @current_tab ||= 0
    @current_tab += 1
  end

  def assign_color(colors_array)
    @color_position ||= -1

    @color_position += 1

    if @color_position > (colors_array.length - 1)
      @color_position = 0
    end

    colors_array[@color_position]

  end

  # Error messages for the specific form field
  def error_message_for(resource, field, options = {:prepend_text => false})

    error_message = resource.errors[field]

    # If the error messages are not empty put the error messages
    # and the prepended text unless it's empty then put the field name.

    unless error_message.empty?
      "#{options[:prepend_text] || field.to_s.capitalize} #{error_message.to_s}".delete! '[]""'
    end

  end



end
