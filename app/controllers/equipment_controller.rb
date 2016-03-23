class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]

  # GET /equipment
  # GET /equipment.json
  def index
      @equipment = Equipment.all
      if params[:keyword].present?
        if params[:keyword] =~ /\d/
          @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:keyword]}%"])
        else
          @equipment = @equipment.where(["lower(name) LIKE ?","%#{params[:keyword]}%"])
        end
      else
        @equipment = Equipment.all
      end
      @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:id]}%"]) if params[:id].present?
      @equipment = @equipment.where(["status = ?",params[:status]]) if params[:status].present?
      @equipment = @equipment.where(["location = ?",params[:location]]) if params[:location].present?
      @equipment = @equipment.where(["department = ?",params[:department]]) if params[:department].present?
  end


  # GET /equipment/1
  # GET /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment
  # POST /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: 'Equipment was successfully created.' }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1
  # PATCH/PUT /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: 'Equipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1
  # DELETE /equipment/1.json
  def destroy
    @equipment.destroy
    respond_to do |format|
      format.html { redirect_to equipment_index_url, notice: 'Equipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def addeditdelete
    @equipment = Equipment.all
  end

  def advance
  end

  def history
  end

  def audit
  end

  def reserved
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
        @equipment = Equipment.find(params[:id])
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:name, :equip_id, :buy_date, :brand, :note, :exp, :status, :serial, :price, :pic_id)
        end

end
