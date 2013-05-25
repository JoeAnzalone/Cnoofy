class LinkPostsController < PostsController

  def new
    @post = LinkPost.new
    puts 'how wow amazing!!!!!!'
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

end