require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe '#welcome_to_app' do
    let(:user) { create(:user, email: 'user@example.com', username: 'TestUser', created_at: Time.current) }
    let(:mail) { described_class.welcome_to_app(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Welcome to App!!!')
    end

    it 'sends to the correct user' do
      expect(mail.to).to eq([user.email])
    end

    it 'uses the default from address' do
      expect(mail.from).to eq(['notifications@appmail.com'])
    end

    it 'renders the body with username' do
      expect(mail.body.encoded).to include(user.username)
    end

    it 'renders the body with created_at date' do
      expect(mail.body.encoded).to include(user.created_at.to_date.to_s)
    end
  end
end
