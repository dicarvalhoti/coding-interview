require 'rails_helper'

RSpec.describe Company, type: :model do
  it "validates presence of name" do
    company = Company.new(name: nil)
    expect(company).to_not be_valid
    expect(company.errors[:name]).to include("can't be blank")
  end

  it "is valid with a name" do
    company = Company.new(name: "Valid Company")
    expect(company).to be_valid
  end

  it "is invalid with a duplicate name" do
    Company.create(name: "Unique Company")
    company = Company.new(name: "Unique Company")
    expect(company).to_not be_valid
    expect(company.errors[:name]).to include("has already been taken")
  end

  
end
