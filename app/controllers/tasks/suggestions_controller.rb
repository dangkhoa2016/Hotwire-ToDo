module Tasks
  # タスクの提案を行う
  class SuggestionsController < ApplicationController
    def create
      @suggestion_request = SuggestionRequest.new(suggestion_request_params.merge(requested_by: current_user))
      unless @suggestion_request.save
        set_view_variables
        render "tasks/new", status: :unprocessable_entity
        return
      end

      SuggestionResponse.batch_create(@suggestion_request, send_chat_request)

      set_view_variables
      render "tasks/new"
    end

    private

      def suggestion_request_params
        params.require(:suggestion_request).permit(:goal, :context, :due_date, :start_date, :project_id)
      end

      def set_view_variables
        @task = @suggestion_request.project.tasks.build
        @show_suggestion = true
      end

      def send_chat_request
        ActiveSupport::Notifications.instrument "chat.openai", request_id: @suggestion_request.id do
          OpenAI::Client.new.chat(parameters: @suggestion_request.openai_params)
        end
      end
  end
end
