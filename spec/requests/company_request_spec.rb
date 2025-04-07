require 'rails_helper'

RSpec.describe "Core::Companies", type: :request do

  before do
    Company.create!(name: "Alpha Inc")
    Company.create!(name: "Beta Ltd")
  end

  describe "GET /app/companies" do
    it "return status 200 and list companies" do
      get "/app/companies"
      expect(response).to have_http_status(200)
      expect(response.body).to include("Alpha Inc")
      expect(response.body).to include("Beta Ltd")
    end

    it "filters companies by the q parameter" do
      get "/app/companies", params: { q: "Alpha" }
      expect(response.body).to include("Alpha Inc")
      expect(response.body).not_to include("Beta Ltd")
    end
  end

  describe "GET /app/companies/:id" do
    it "displays an existing company" do
      company = Company.first
      get "/app/companies/#{company.id}"
      expect(response).to have_http_status(200)
      expect(response.body).to include(company.name)
    end
  end

  describe "POST /app/companies" do
    it "creates a company with valid data" do
      expect {
        post "/app/companies", params: { company: { name: "New Conmpany" } }
      }.to change(Company, :count).by(1)

      expect(response).to redirect_to(Company.last)
      follow_redirect!
      expect(response.body).to include("New Conmpany")
    end

    it "do not create company with invalid data" do
      expect {
        post "/app/companies", params: { company: { name: "" } }
      }.not_to change(Company, :count)

      expect(response.body).to include("Error creating Company")
    end
  end

  describe "GET /app/companies/:id/edit" do
    let!(:company) { Company.create!(name: "New Company") }
  
    it "renders the edit form successfully" do
      get "/app/companies/#{company.id}/edit"
  
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Editing Company: ")
      expect(response.body).to include(company.name)
    end
  end

  describe "POST /app/companies/:id/update_data" do
    let!(:company) { Company.create!(name: "Old Company") }
  
    it "updates a company using POST" do
      post "/app/companies/#{company.id}/update_data", params: {
        company: { name: "Edited Company" }
      }
  
      expect(response).to redirect_to(core.company_path(company.reload))
      follow_redirect!
      expect(response.body).to include("Edited Company")
    end
  
    it "does not update company with invalid data" do
      post "/app/companies/#{company.id}/update_data", params: {
        company: { name: "" }
      }
  
      expect(response.body).to include("Error updating Company")
      expect(company.reload.name).to eq("Old Company")
    end
  end

  describe "DELETE /companies/:id/" do
    it "delete a company" do
      company = Company.first
      expect {
        delete "/app/companies/#{company.id}/delete"
      }.to change(Company, :count).by(-1)

      expect(response).to redirect_to("/app/companies")
    end
  end
end
