module ApplicationHelper

  def autoTabIndex
    @current_tab ||= 0
    @current_tab += 1
  end

end
