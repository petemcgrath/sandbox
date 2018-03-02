class PixelController < ApplicationController

  def inc
    pixel = Pixel.find_by_id(params[:pixel_id])
    if pixel.present?
      pixel.count += 1
      pixel.save!

      @count = pixel.count
    end
  end

  def create_new_pixel
    pixel = Pixel.find_or_create_by(id: params[:pixel_id])
    @count = pixel.count

    render :inc
  end

end
