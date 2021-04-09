class TopsController < ApplicationController
  def index
    @post = Post.includes(:favorites, :user).all
  end
end
