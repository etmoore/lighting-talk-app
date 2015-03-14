require 'rails_helper'

feature 'Admin Lightning Talks' do
  before {
    User.destroy_all
    @user = User.create!(username: "deitrick smells", email: "andrew@internet.com", auth_token: "abc123", admin: true)
    @day = Day.create!(talk_date: Date.today, number_of_slots: 5)
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
       :provider => 'github',
       :uid => '123545',
       :info => {
         :nickname => @user.username,
         :email => @user.email,
       },
       credentials: OmniAuth::AuthHash.new(token: @user.auth_token),
    })
    visit root_path
    click_on 'Sign In'
  }

  scenario 'Admin can visit Admin lightning talks index' do
    talk = LightningTalk.create!(user: @user, day_id: @day.id, name: 'Test Talk')
    visit admin_lightning_talks_path
    expect(page).to have_content 'Manage Talks'
    expect(page).to have_content 'Test Talk'
    expect(page).to have_content @user.username
  end

  scenario 'Admin can create a new lightning talk' do
    visit admin_lightning_talks_path

    click_on 'New Lightning Talk Admin'

    fill_in 'Talk Topic', with: 'Another Test Talk'
    select @day.talk_date, from: "Day"
    click_on 'Create Lightning Talk'

    expect(current_path).to eq(admin_lightning_talks_path)
    expect(page).to have_content @day.talk_date.strftime("%m/%d/%Y")
    expect(page).to have_content 'Another Test Talk'
  end

  scenario 'Admin can edit a lightning talk' do
    new_day = Day.create!(talk_date: Date.tomorrow, number_of_slots: 5)
    talk = LightningTalk.create!(user: @user, day_id: @day.id, name: 'Test Talk')

    visit admin_lightning_talks_path
    expect(page).to have_content 'Test Talk'
    click_on 'Edit'

    fill_in 'Talk Topic', with: 'Changed the words'
    select new_day.talk_date, from: "Day"
    click_on 'Update Lightning Talk'

    expect(page).to have_content 'Changed the words'
    expect(page).to have_content new_day.talk_date.strftime("%m/%d/%Y")
    expect(page).to have_no_content 'Test Talk'
  end

  scenario 'Admin can delete a lightning talk' do
    talk = LightningTalk.create!(user: @user, day_id: @day.id, name: 'Test Talk')

    visit admin_lightning_talks_path

    expect(page).to have_content 'Delete'
    expect(page).to have_content 'Test Talk'

    click_on 'Delete'

    expect(current_path).to eq(admin_lightning_talks_path)
    expect(page).to have_no_content 'Test Talk'
  end

end
