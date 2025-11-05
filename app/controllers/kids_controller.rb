class KidsController < ApplicationController
  before_action :authenticate_user!

  def new
    @kid = Kid.new
  end

  def create
    @kid = current_user.kids.build(kid_params)
    if @kid.save
      redirect_to kids_path, notice: '登録しました.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @kids = current_user.kids
  end

  private

  def kid_params
    params.require(:kid).permit(:name, :birthday)
  end
end
