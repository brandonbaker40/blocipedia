module ControllerMacros
  def login_admin_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = User.create(email: 'blocadmin@bloc.io', password: 'honeybunchesofoats1234', role: 2)
      sign_in admin
    end
  end

  def login_premium_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:premium]
      premium = User.create(email: 'blocpremium@bloc.io', password: 'luckycharms1234', role: 1)
      sign_in premium
    end
  end

  def login_standard_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:standard]
      standard = User.create(email: 'blocstandard@bloc.io', password: 'frostedflakes1234', role: 0)
      sign_in standard
    end
  end

  def downgrade_premium_to_standard
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:premium]
      premium = User.create(email: 'blocpremiumtodowngrade@bloc.io', password: 'cocoapuffs1234', role: 1)
      sign_in premium
      premium.update(role: 0)
    end
  end
end
