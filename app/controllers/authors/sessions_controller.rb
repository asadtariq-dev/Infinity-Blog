# frozen_string_literal: true

module Authors
  class SessionsController < Devise::SessionsController
    # DELETE /resource/sign_out
    def destroy
      super do
        return redirect_to new_author_session_path
      end
    end
  end
end
