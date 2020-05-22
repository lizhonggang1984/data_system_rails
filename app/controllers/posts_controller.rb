class PostsController < ApplicationController
  before_action :check_login

  def new
  end

  def create
    head = params[:post][:head]
    body = params[:post][:body].strip
    if head.blank?
      flash.notice = "Empty head not allowed"
    elsif body.length < 8
      flash.notice = "length is less than 8"
    else
      post = Post.new(account_id: @current_user.id,as_type:0,status:0)
      post.head = head
      post.body = body
      boolean = post.save
      if boolean
        flash.notice = "Success"
        redirect_to :root
      else
        flash.notice = "Fail"
        render "/posts/new"
      end
    end
  end

end
