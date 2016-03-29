class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :index,:advance,:history]
  # GET /equipment
  # GET /equipment.json
  #require 'zbar'
  def index

    @equipment = Equipment.all
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

    @history = History.all
    @history.create(action: 'add_new_item',
                 user_name: current_user.name,
                 equip_id: @equipment.equip_id)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to equipment_addeditdelete_path, notice: 'Equipment was successfully add.' }
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
    @history = History.all
    @history.create(action: 'delete_item',
                 user_name: current_user.name,
                 equip_id: @equipment.equip_id)
    respond_to do |format|
      format.html { redirect_to equipment_addeditdelete_url, notice: 'Equipment was successfully delete.' }
      format.json { head :no_content }
    end
  end

  def addeditdelete
    @equipment = Equipment.all
  end

  def result
    @qr1 = Qrio::Qr.load("public/qrpic/blank.png").qr.text
    #@qr2 = ZBar::Image.from_jpeg(File.read('public/qrpic/abcd.JPG')).process
    #@qr3 = ZXing.decode 'http://2d-code.co.uk/images/bbc-logo-in-qr-code.gif'
    @history = History.all
    @history.create(action: 'search_by_keyword',
                 user_name: current_user.name,
                 keyword: params[:keyword])

  if @qr1  != ''
      params[:keyword] = @qr1
    else
    end
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
    @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:equip_id]}%"]) if params[:equip_id].present?
    @equipment = @equipment.where(["status = ?",params[:status]]) if params[:status].present?
    @equipment = @equipment.where(["lower(brand) LIKE ?",params[:brand]]) if params[:brand].present?
    @equipment = @equipment.where(["buy_date = ?",params[:buy_date]]) if params[:buy_date].present?
    @equipment = @equipment.where(["exp = ?",params[:exp]]) if params[:exp].present?
  end

  def item
    @equipment = Equipment.all
    @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:equip_id]}%"]) if params[:equip_id].present?
  end

  def history
  end

  def audit
    @equipment = Equipment.where("process = ?","Pending")
    @equipment = @equipment.where("ownby = ?",current_user.name)

    @equipment_c = Equipment.where("process = ?","Complete")
  end

  def myitem
    @equipment = Equipment.all
    @equipment = @equipment.where("ownby = ?",current_user.name)
  end

  def cancel
    @equipment = Equipment.find_by(equip_id: params[:equip_id])
    @equipment.update(status: 'Available',ownby: '',process: '')
    @history = History.all
     @history.create(action: 'cancel_reserve',
                 user_name: current_user.name,
                 equip_id: params[:equip_id])
    redirect_to equipment_myitem_path
  end

  def return
    @equipment = Equipment.find_by(equip_id: params[:equip_id])
    @equipment.update(status: 'Available',ownby: '',process: '')
    redirect_to equipment_audit_path
  end

  def doreserve
    @name = current_user.name
    @equipment = Equipment.find_by(equip_id: params[:equip_id])
    @equipment.update(status: 'Pending',process: 'Pending' )
    @equipment.update(ownby: @name)
    @history = History.all
    @history.create(action: 'reserve_item',
                 user_name: current_user.name,
                 equip_id: params[:equip_id])
    redirect_to :back
  end

  def approve
    @equipment = Equipment.find_by(equip_id: params[:equip_id])
    @equipment.update(process: 'Complete',status: 'Reserved')
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
        @equipment = Equipment.find(params[:id])
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:process,:ownby,:status,:name, :equip_id, :buy_date, :brand, :note, :exp, :status, :serial, :price, :pic_id)
        end

end
