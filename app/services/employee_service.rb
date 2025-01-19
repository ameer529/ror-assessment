require 'net/http'
require 'net/https'

class EmployeeService
  BASE_URL = 'https://dummy-employees-api-8bad748cda19.herokuapp.com/employees'.freeze

  def self.fetch_employees(page: nil)
    uri = URI(BASE_URL)
    uri.query = "page=#{page}" if page.present?

    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error("Error fetching employees: #{e.message}")
    []
  end

  def self.fetch_employee(id)
    uri = URI("#{BASE_URL}/#{id}")

    response = Net::HTTP.get(uri)
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error("Error fetching employee with ID #{id}: #{e.message}")
    nil
  end

  def self.create_employee(params)
    uri = URI(BASE_URL)
    request = build_request(Net::HTTP::Post, uri, params)

    execute_request(uri, request)
  end

  def self.update_employee(id, params)
    uri = URI("#{BASE_URL}/#{id}")
    request = build_request(Net::HTTP::Put, uri, params)

    execute_request(uri, request)
  end

  private

  def self.build_request(http_method, uri, params)
    request = http_method.new(uri)
    request['Content-Type'] = 'application/json'
    request.body = params.to_json
    request
  end

  def self.execute_request(uri, request)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    response = http.request(request)

    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error("Error during request to #{uri}: #{e.message}")
    nil
  end
end
