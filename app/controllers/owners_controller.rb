class OwnersController < ApplicationController
  before_action :set_owner, only: [:show, :edit, :update, :destroy]

  def index
    @owners = Owner.includes(:pets).all
  end

  def index
    @owners = policy_scope(Owner).includes(:pets)
  end

  def new
    @owner = Owner.new
    authorize @owner
  end

  def create
    @owner = Owner.new(owner_params)
    authorize @owner
    if @owner.save
      redirect_to @owner, notice: 'Owner was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @owner.update(owner_params)
      redirect_to @owner, notice: 'Owner was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @owner.destroy
    redirect_to owners_path, notice: 'Owner was successfully deleted.'
  end

  private

    def set_owner
      @owner = Owner.find(params[:id])
      # Le pasamos el registro a Pundit para que autorice (Show, Edit, Update, Destroy)
      authorize @owner 
    end

  def owner_params
    params.require(:owner).permit(:first_name, :last_name, :email, :phone, :address)
  end
end