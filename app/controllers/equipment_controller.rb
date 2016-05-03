class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:show, :home,:advance,:result]
  helper :headshot
  # GET /equipment
  # GET /equipment.json
  #require 'zbar'
  def home
    @equipment = Equipment.all
    if user_signed_in?
        session[:sign_in] = true
      else
        @sign_in = false
      end
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
    #if params[:qr_pic] != ''
      #@qrcodepath = "'public/headshots/" + "#{params[:qr_pic]}" + ".png'"
      #params[:qr_id] == Qrio::Qr.load(@qrcodepath).qr.text
    #else
    #end
    #@qr1 = Qrio::Qr.load("public/qrpic/1.png").qr.text
    #params[:qr_id] = @qr1
    #@qr_input = 'no'
    #@qr2 = ZBar::Image.from_jpeg(File.read('public/qrpic/abcd.JPG')).process
    if user_signed_in?
      @current_user = current_user.name
    else 
      @current_user = 'Guest'
    end
    @history = History.all
    @history.create(action: 'search_by_keyword',
                 user_name: @current_user,
                 keyword: params[:keyword])

  #if @qr_input  == 'yes' #@qr1 != ''
  #   params[:keyword] = @qr1
  # else
  # end
    @equipment = Equipment.all
    if params[:keyword].present?
      if params[:keyword] =~ /\d/
        @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:keyword]}%"])
      else
        @equipment = @equipment.where(["lower(name) LIKE ?","%#{params[:keyword]}%"])
      end
    elsif params[:keyword_2].present?
      if params[:keyword_2] =~ /\d/
        @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:keyword_2]}%"])
      else
        @equipment = @equipment.where(["lower(name) LIKE ?","%#{params[:keyword_2]}%"])
      end
    else
      @equipment = Equipment.all
    end
    @equipment = @equipment.where(["qr_id LIKE ?","%#{params[:qr_id]}%"]) if params[:qr_id].present?
    @equipment = @equipment.where(["campus LIKE ?","%#{params[:campus]}%"]) if params[:campus].present?
    @equipment = @equipment.where(["equip_id LIKE ?","%#{params[:equip_id]}%"]) if params[:equip_id].present?
    @equipment = @equipment.where(["status = ?",params[:status]]) if params[:status].present?
    @equipment = @equipment.where(["lower(brand) LIKE ?",params[:brand]]) if params[:brand].present?
    @equipment = @equipment.where(["buy_date = ?",params[:buy_date]]) if params[:buy_date].present?
    @equipment = @equipment.where(["exp = ?",params[:exp]]) if params[:exp].present?
  end

  def reported_detail
    @item = Report.find_by(id: params[:id])
    @image = true
    @img_path = "/report_pic/" + "#{@item.pic_id}" + ".jpg"
  end

  def checked
    Report.find_by(id: params[:id]).update(checked_status: 'Checked')
    redirect_to :back
  end

  def unchecked
    Report.find_by(id: params[:id]).update(checked_status: 'Not check')
    redirect_to :back
  end

  def check_item
    Report.find_by(id: params[:id]).update(staff_note: params[:staff_note],
      action_needed: params[:action_needed])
    redirect_to equipment_reported_item_path
  end

  def item
    @equipment = Equipment.find_by(equip_id: params[:equip_id])
    @path = "/photos/" + "#{@equipment.equip_id}" + ".jpg"
  end

  def history
  end

  def audit
    @equipment = Equipment.where("process = ?","Pending")
    if current_user.name == 'user'
      @equipment = @equipment.where("ownby = ?",current_user.name)
    else
    end

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

   def upload
    @id = params[:equip_id]
    @name = "#{@id}" + ".jpg" 
    directory = "public/photos/"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }
    flash[:notice] = "File uploaded"
    redirect_to :back
  end

  def upload_report
    #@img_path = "/report_pic/" + "#{params[:equip_id]}" + ".jpg"
    @id = params[:equip_id]
    @name = "#{@id}" + ".jpg" 
    directory = "public/report_pic/"
    path = File.join(directory, @name)
    File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }

    redirect_to :back
  end

  def report  
  end
  
  def doreport
    @id = params[:equip_id]
    if @id != ''
      @name = "#{@id}" + "-" + "#{Time.now.to_formatted_s(:number)}" + ".jpg" 
      @pic_id = "#{@id}" + "-" + "#{Time.now.to_formatted_s(:number)}"
      directory = "public/report_pic/"
      path = File.join(directory, @name)
      File.open(path, "wb") { |f| f.write(params[:upload][:file].read) }
    else
    end
  end

  def notification
  end

  def cart
    @equipment = Equipment.all
  end

  def qrscanner
  end

  def qrsubmit
    redirect_to equipment_result_path(qr_id: params[:qr_id])
    Report.create(title: params[:title],
                            equip_id: params[:equip_id],
                            equip_type: params[:type],
                            note: params[:note],
                            user_name: current_user.name,
                            pic_id: @pic_id)

    History.create(action: 'report_item',
                 user_name: current_user.name,
                 equip_id: params[:equip_id],
                 detail: params[:note])
    redirect_to :back
  end

  def reported_item
    @report = Report.all
  end

  def dashboard
    
  end

  def barcode_gen
    #@barcode = Barcodes.create('Code 39', {:data => 'BD6193-001-42110012F'})
    #pdf_renderer = Barcodes::Renderer::Pdf.new(@barcode)
    #pdf_renderer.render('./public/output.pdf')

    qrcode = RQRCode::QRCode.new("BD7195-001-42110012F")
    image = qrcode.as_png
    string = qrcode.to_s
    png = qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 240,
          border_modules: 4,
          module_px_size: 6,
          file: nil # path to write
          )
    IO.write("./public/qrcode.png", png.to_s.force_encoding("UTF-8"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
        @equipment = Equipment.find(params[:id])
     end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipment_params
      params.require(:equipment).permit(:location,:process,:ownby,:status,:name, :equip_id, :buy_date, :brand, :note, :exp, :status, :serial, :price, :pic_id)
        end

  end
