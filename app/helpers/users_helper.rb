module UsersHelper
  def founder_badge(user)
    user.badges.find_by(name: "Founder")
  end
end
