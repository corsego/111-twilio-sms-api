# Twilio::SmsService.new(body: 'hello from SupeRails!', to_phone_number: '+48537628023')

module Twilio
  class SmsService
    TWILIO_ACCOUNT_SID = Rails.application.credentials.dig(:twilio, :account_sid)
    TWILIO_AUTH_TOKEN = Rails.application.credentials.dig(:twilio, :auth_token)
    TWILIO_FROM_PHONE = Rails.application.credentials.dig(:twilio, :from_phone)
    TWILIO_TEST_PHONE = Rails.application.credentials.dig(:twilio, :test_phone)

    def initialize(body:, to_phone_number:)
      @body = body
      @to_phone_number = to_phone_number
    end

    def call
      @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
      message = @client.messages
        .create(
          body: @body,
          from: TWILIO_FROM_PHONE,
          to: to(@to_phone_number)
        )
      puts message.sid
    end

    private

    def to(to_phone_number)
      return TWILIO_TEST_PHONE if Rails.env.development?

      to_phone_number
    end
  end
end