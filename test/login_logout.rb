module LoginLogout
  def login_as(role)
    @user = FactoryBot.create(:user, username: "tester#{rand(999)}", role: role.to_s)
    if role == :customer
      @customer = FactoryBot.create(:customer, user: @user)
    else
      @employee = FactoryBot.create(:employee, user: @user)
    end
    get login_path
    post sessions_path, params: { username: @user.username, password: "secret" }    
  end

  def login_user(user)
    get login_path
    post sessions_path, params: { username: user.username, password: 'secret' }
  end
  
  def logout_now
    get logout_path
  end
end