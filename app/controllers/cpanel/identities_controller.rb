class Cpanel::IdentitiesController < Cpanel::ApplicationController
  before_action :set_identity, only: [:edit, :destroy]

  def index
  end

  def edit
  end

  def destroy
    @identity.destroy
    respond_to do |format|
      format.html { redirect_to cpanel_users_url }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_identity
      @identity = Identity.find(params[:id])
    end



end
