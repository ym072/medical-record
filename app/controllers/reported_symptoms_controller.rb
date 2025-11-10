class ReportedSymptomsController < ApplicationController
  before_action :set_kid
  before_action :set_disease_record, only: [:new, :create]

  def new
    if @disease_record.present?
      @show_start_popup = false
      @reported_symptom = @disease_record.reported_symptoms.new
    else
      @show_start_popup = true
      @reported_symptom = nil
    end
  end

  def start_record
    @disease_record = @kid.disease_records.find_by(end_at: nil)

    if @disease_record.present?
      redirect_to new_kid_reported_symptom_path(@kid), notice: "記録中です。"
    else
      @disease_record = @kid.disease_records.create!(start_at: Time.current)
      redirect_to new_kid_reported_symptom_path(@kid), notice: "記録をスタートしました。"
    end
  end

  def create
    unless @disease_record
      redirect_to new_kid_reported_symptom_path(@kid), alert: "記録をスタートしてください。"
      return
    end
  
    commit_type = params[:commit_type]
    @reported_symptom = @disease_record.reported_symptoms.new(reported_symptom_params)
    @reported_symptom.recorded_at = Time.current
  
    case commit_type
    when "temperature"
      @reported_symptom.body_temperature = params[:reported_symptom][:body_temperature]
      @reported_symptom.symptom_name_id ||= SymptomName.find_by(name: "その他")&.id
      message = "体温を記録しました"
  
    when "memo"
      @reported_symptom.memo = params[:reported_symptom][:memo]
      @reported_symptom.symptom_name_id ||= SymptomName.find_by(name: "その他")&.id
      message = "メモを記録しました"
  
    when "disease_name"
      @disease_record.update(name: params[:reported_symptom][:disease_name])
      redirect_to new_kid_reported_symptom_path(@kid), notice: "病名を記録しました"
      return
  
    else
      if @reported_symptom.symptom_name_id.present?
        symptom_name = @reported_symptom.symptom_name.name
        message = "#{symptom_name}を記録しました"
      else
        message = "症状を記録しました"
      end
    end
  
    if @reported_symptom.save
      redirect_to new_kid_reported_symptom_path(@kid), notice: message
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def set_kid
    @kid = current_user.kids.find(params[:kid_id])
  end

  def set_disease_record
    @disease_record = @kid.disease_records.find_by(end_at: nil)
  end

  def reported_symptom_params
    params.require(:reported_symptom).permit(:symptom_name_id, :recorded_at, :memo, :body_temperature)
  end
end
