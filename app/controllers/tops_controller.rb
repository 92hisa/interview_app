class TopsController < ApplicationController
  def index
    @post = Post.all
  end
end
