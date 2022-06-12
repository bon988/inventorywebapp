class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /inventories or /inventories.json
  def index
    @inventories = Inventory.all
  end

  # GET /inventories/1 or /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    # @inventory = Inventory.new
    @inventory = current_user.inventories.build

  end

  # GET /inventories/1/edit
  def edit
  end

  # POST /inventories or /inventories.json
  def create
    # @inventory = Inventory.new(inventory_params)
    @inventory = current_user.inventories.build(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to inventory_url(@inventory), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @inventory = current_user.inventories.find_by(id: params[:id])
    redirect_to inventories_path, notice: "Not authorized to edit this product" if @inventory.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])

    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.require(:inventory).permit(:product_name, :price, :quantity, :category, :vendor, :user_id)
    end
end
