class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:create]


  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = Node.all.asc(:position)
  end

  def show
  end

  def new
    @node = Node.new
  end

  def edit
  end

  def create
    @node = Node.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to @node, notice: t('created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @node, notice: t('updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:name, :position, :parent_node_id)
    end
end
