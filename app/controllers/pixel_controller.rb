class PixelController < ApplicationController

  def index
    render json: Pixel.all
  end

  def inc
    pixel = Pixel.find_by_id(params[:pixel_id])
    if pixel.present?
      pixel.count += 1
      pixel.save!
    end

    render json: pixel.present? ? pixel.count : nil
  end

  def create_new_pixel
    pixel = Pixel.find_or_create_by(id: params[:pixel_id])
    @count = pixel.count

    render json: pixel.present? ? pixel.count : nil
  end

end
