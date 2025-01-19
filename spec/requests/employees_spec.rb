# spec/requests/employees_spec.rb
require 'rails_helper'

RSpec.describe "EmployeesController", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  context "with valid parameters" do
    it "creates a new employee and can be retrieved via GET" do
      employee_params = {
        employee: {
          name: "John Doe",
          position: "Software Engineer",
          date_of_birth: "1990-01-01",
          salary: 60000
        }
      }
      post employees_path, params: employee_params
      expect(response).to redirect_to(employee_path(Employee.last))
      follow_redirect!

      expect(response.body).to include("John Doe")
      get employee_path(Employee.last)
      expect(response).to be_successful
      expect(response.body).to include("John Doe")
      expect(response.body).to include("Software Engineer")
      expect(response.body).to include("60000")
    end
  end
end
