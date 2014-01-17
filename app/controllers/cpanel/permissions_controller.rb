class Cpanel::PermissionsController < Cpanel::ApplicationController
  before_action :set_cpanel_permission, only: [:show, :edit, :update, :destroy]

  # GET /cpanel/permissions
  # GET /cpanel/permissions.json
  def index
    @permissions = Permission.all.asc(:subject ,:_id)
  end

  # GET /cpanel/permissions/1
  # GET /cpanel/permissions/1.json
  def show
  end

  # GET /cpanel/permissions/new
  def new
    @permission = Permission.new
  end

  # GET /cpanel/permissions/1/edit
  def edit
  end

  # POST /cpanel/permissions
  # POST /cpanel/permissions.json
  def create
    @permission = Permission.new(cpanel_permission_params)

    respond_to do |format|
      if @permission.save
        format.html { redirect_to [:cpanel, @permission], notice: 'Permission was successfully created.' }
        format.json { render action: 'show', status: :created, location: @permission }
      else
        format.html { render action: 'new' }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cpanel/permissions/1
  # PATCH/PUT /cpanel/permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(cpanel_permission_params)
        format.html { redirect_to [:cpanel, @permission], notice: 'Permission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpanel/permissions/1
  # DELETE /cpanel/permissions/1.json
  def destroy
    @permission.destroy
    respond_to do |format|
      format.html { redirect_to cpanel_permissions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpanel_permission
      @permission = Permission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpanel_permission_params
      params.require(:permission).permit(:action, :subject, :description)
    end
end
