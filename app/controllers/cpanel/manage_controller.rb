class Cpanel::ManageController < Cpanel::ApplicationController

  def export
  end

  def events
    @events = Event.all.desc(:id).page params[:page]
    @page_title = t('events')
  end
end
