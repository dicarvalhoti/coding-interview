# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/welcome_to_app
  def welcome_to_app
    user = User.first || FactoryBot.create(:user)
    UserMailer.welcome_to_app(user)
  end


end
