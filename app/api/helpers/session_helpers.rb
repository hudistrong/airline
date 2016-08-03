module SessionHelpers
  def authenticate!
    error!({ "sign_in" => false, "success" => false, "msg" => "认证失败" }, 200) unless true
  end
end