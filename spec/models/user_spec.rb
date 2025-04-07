require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'scopes' do
    let!(:company1) { create(:company, name: 'Acme Corp') }
    let!(:company2) { create(:company, name: 'Beta Inc') }

    let!(:user1) { create(:user, username: 'john_doe', company: company1) }
    let!(:user2) { create(:user, username: 'jane_doe', company: company2) }
    let!(:user3) { create(:user, username: 'admin_user', company: company1) }

    describe '.by_company' do
      it 'returns users from the given company' do
        result = User.by_company(company1)
        expect(result).to contain_exactly(user1, user3)
      end

      it 'returns all users when company is nil' do
        result = User.by_company(nil)
        expect(result).to include(user1, user2, user3)
      end

      it 'returns empty when company has no users' do
        empty_company = create(:company)
        result = User.by_company(empty_company)
        expect(result).to be_empty
      end
    end

    describe '.by_username' do
      it 'returns users whose usernames match partial string' do
        result = User.by_username('doe')
        expect(result).to contain_exactly(user1, user2)
      end

      it 'returns all users when username is nil' do
        result = User.by_username(nil)
        expect(result).to include(user1, user2, user3)
      end

      it 'returns empty when no usernames match' do
        result = User.by_username('xyz')
        expect(result).to be_empty
      end
    end
  end

end
