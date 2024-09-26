class MainController < ApplicationController
  def show
    @sqids_alphabet = Rails.application.credentials.sqids_alphabet
    sqids = Sqids.new(alphabet: @sqids_alphabet)
    id = params[:id]
    id = remove_word_from_string(id, "development-")
    decoded = sqids.decode(id)
    begin
      @session = Session.find(decoded[0])
      render json: { session: @session, event: @session.event, export: @session.export.order(created_at: :desc) }, status: :ok
    rescue
      render json: { session: nil, event: nil, export: nil }, status: "404"
    end
  end

  private

  def remove_word_from_string(original_string, word_to_remove)
    original_string.gsub(/\b#{Regexp.escape(word_to_remove)}\b/, "").strip
  end
end
