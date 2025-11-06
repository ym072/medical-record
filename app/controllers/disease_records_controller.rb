class DiseaseRecordsController < ApplicationController
  before_action :set_kid

  def new
    @disease_record = @kid.disease_records.new
  end

  def create
    @disease_record = @kid.disease_records.build(disease_record_params)
    if @disease_record.save
        redirect_to kid_path(@kid), notice: "記録スタート"
    else
        render :new, status: :unprocessable_entity
    end
  end

  private

  def set_kid
    @kid = current_user.kids.find(params[:kid_id])
  end

  def disease_record_params
    params.require(:disease_record).permit(:start_at, :end_at, :notes)
  end
end
