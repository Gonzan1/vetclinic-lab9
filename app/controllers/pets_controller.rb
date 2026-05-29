class PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  def index
    @pets = policy_scope(Pet).includes(:owner)  
  end

  def show
  end

  def new
    @pet = Pet.new
    authorize @pet
  end

  def create
    @pet = Pet.new(pet_params)
    authorize @pet
    if @pet.save
      redirect_to @pet, notice: 'Pet was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to pets_path, notice: 'Pet was successfully deleted.'
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :weight, :date_of_birth, :owner_id)
  end

  def pet_params
      params.require(:pet).permit(:name, :species, :breed, :weight, :date_of_birth, :owner_id, :photo)
    end
end