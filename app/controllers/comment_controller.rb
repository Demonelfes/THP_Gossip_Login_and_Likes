class CommentController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    @current_gossip = Gossip.find(params[:gossip_id].to_i)
    if logged_in?
      @comment = Comment.new(
        'user_id' => current_user.id,
        'gossip_id' => @current_gossip.id,
        'content' => params[:content]
      )
      puts params
      if @comment.save
        redirect_to gossip_path(@current_gossip)
      else
        render :new
      end
    else
      redirect_to new_session_path(logged_in_failed: true)
    end
  end

  def edit
    @current_gossip = Gossip.find(params[:gossip_id].to_i)
    @current_comment = @current_gossip.comments.find(params[:id].to_i)
  end

  def update
    @current_gossip = Gossip.find(params[:gossip_id].to_i)
    @current_comment = @current_gossip.comments.find(params[:id].to_i)
    comment_params = params.permit(:content)

    if !logged_in?
      redirect_to root_path(connection_failed: true)
    elsif @current_comment.user.id == current_user.id
      @current_comment.update(comment_params)
      redirect_to gossip_path(@current_gossip)#(:update_success)
    else
      redirect_to gossip_path(@current_gossip, update_failed: true)#(:update_failed)
    end

  end

  def destroy
    @current_gossip = Gossip.find(params[:gossip_id].to_i)
    @current_comment = @current_gossip.comments.find(params[:id].to_i)

    if !logged_in?
      redirect_to root_path(connection_failed: true)
    elsif @current_comment.user.id == current_user.id
      @current_comment.destroy
      redirect_to gossip_path(@current_gossip)#gossip_path()#(:destroy_success)
    else
      redirect_to root_path()
    end
  end
end
