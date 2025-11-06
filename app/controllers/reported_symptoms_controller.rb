class ReportedSymptomsController < ApplicationController
  before_action :set_kid
  before_action :set_disease_record

  def new
    if @disease_record.nil?
      @show_start_popup = true
      @disease_record = @kid.disease_records.new
    else
      @reported_symptom = @disease_record.reported_symptoms.new
    end
  end

  def create
    @reported_symptom = @disease_record.reported_symptoms.new(reported_symptom_params)

    if @reported_symptom.save
      if params[:commit] == "治った！"
        @disease_record.update(end_at: Time.current)
        redirect_to kid_path(@kid), notice: "看病お疲れ様でした！"
      else
        redirect_to new_kid_reported_symptom_path(@kid), notice: "記録しました"
      end
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
    params.require(:reported_symptom).permit(:symptom_name_id, :recorded_at, :memo, :body_temperature, :name)
  end
end
