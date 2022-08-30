class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /spices
  def index
    render json: Spice.all, status: :ok
  end

  # POST /spices
  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  # PATCH /spices/:id
  def update
    find_spice.update(spice_params)
    render json: find_spice, status: :accepted
  end

  # DELETE /spices/:id
  def destroy
    find_spice.destroy
    head :no_content
  end

  private

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def spice_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def render_not_found_response
    render json: { error: "Spice not found" }, status: :not_found
  end

end
