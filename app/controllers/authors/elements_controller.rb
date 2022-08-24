module Authors
  class ElementsController < AuthorsController
    before_action :set_post
    before_action :set_element, only: %i[update destroy]

    # POST /elements or /elements.json
    def create
      @element = @post.elements.build(element_params)

      notice = if @element.save
                 nil
               else
                 @element.errors.full_messages.join('.') << '.'
               end
      redirect_to edit_post_path(@post), notice: notice
    end

    # PATCH/PUT /elements/1 or /elements/1.json
    def update
      redirect_to edit_post_path(@element.post) if @element.update(element_params)
    end

    # DELETE /elements/1 or /elements/1.json
    def destroy
      @element.destroy

      respond_to do |format|
        format.html { redirect_to elements_url, notice: 'Element was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_post
      @post = current_author.posts.find(params[:post_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = @post.elements.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def element_params
      params.require(:element).permit(:element_type, :content)
    end
  end
end
