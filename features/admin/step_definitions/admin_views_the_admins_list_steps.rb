Given "there are {int} other active Admins" do |count|
  count.times do
    current = Admin.all.count

    Admin.create(
      email: "admin#{current}@example.com",
      password: "supersekrat"
    )
  end
end

Given "there are {int} other blocked Admins" do |count|
  count.times do
    current = Admin.all.count

    Admin.create(
      email: "badmin#{current}@example.com",
      password: "supersekrat",
      blocked: true
    )
  end
end

When "I browse to the Admins page" do
  find_link('Admins').click
end

Then "I land on the Admins list" do
  expect(page).to have_current_path("/admins")
end

Given "I'm on the Admins list" do
  step "I'm using the dashboard"
  step "I browse to the Admins page"
end

Then "I see a list of all admins" do
  Admin.all.each do |admin|
    expect(page).to have_selector("#admin-#{admin.id}")
  end
end

Then "I see the email address for each of those admins" do
  Admin.all.each do |admin|
    expect(page).to have_content(admin.email)
  end
end

Then "I see each of the admins' status" do
  Admin.all.each do |admin|
    within("#admin-#{admin.id}") do
      if admin.blocked
        expect(page).to have_content('Disabled')
      else
        expect(page).to have_content('Active')
      end
    end
  end
end
