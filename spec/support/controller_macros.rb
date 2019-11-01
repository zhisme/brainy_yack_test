module ControllerMacros
  def json_body
    JSON.parse subject.body
  rescue StandardError
    nil
  end
end
