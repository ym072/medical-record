class DiseaseRecordsController < ApplicationController
  before_action :set_kid
  before_action :set_disease_record, only: [:end_form, :end_update]

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

  def end_form
  end

  def end_update
    if @disease_record.update(end_at: disease_record_params[:end_at])
      redirect_to kid_path(@kid), notice: "体調不良の終了日時を登録しました。"
    else
      flash.now[:alert] = "終了日時の登録に失敗しました。"
      render :end_form, status: :unprocessable_entity
    end
  end


  private

  def set_kid
    @kid = current_user.kids.find(params[:kid_id])
  end

  def set_disease_record
    @disease_record = @kid.disease_records.find(params[:id])
  end

  def disease_record_params
    params.require(:disease_record).permit(:start_at, :end_at, :notes)
  end
end
