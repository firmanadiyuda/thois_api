class SqidsService
  def initialize(data)
    @data = data
    @sqids_alphabet = Rails.application.credentials.sqids_alphabet
  end

  def call
    sqids = Sqids.new(alphabet: @sqids_alphabet)
    encoded = sqids.decode(@data)
    encoded
  end
end
