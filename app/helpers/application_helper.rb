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


end
