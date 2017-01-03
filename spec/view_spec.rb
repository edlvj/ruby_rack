require 'spec_helper'

feature Racker do
  background do
    visit '/'
    click_button('Start Play')
  end

  scenario 'Decreases attempts', js: true do    
    fill_in('code', with: '1234')
    click_button('check')
    expect(page).to have_content('9')
  end

  scenario 'Show Result', js: true do    
    fill_in('code', with: '1234')
    click_button('check')
    expect(page.first('#result').text).not_to eql('')
  end

  scenario 'Give a hint', js: true do
    click_button('Hint')
    expect(page.first('#hint_result').text).to match(/[\d]{1}/)
  end

  scenario 'End hints', js: true do
    2.times do
      click_button('Hint')
    end
    expect(page.first('#hint_result').text).to eq("Not Available")
  end

  scenario 'Loss game', js: true do
    11.times do
      fill_in('code', with: '1234')
      click_button('check')
    end
    expect(page).to have_content("You Loose")
  end

  scenario 'show table after save', js: true do
    11.times do
      fill_in('code', with: '1234')
      click_button('check')
    end

    fill_in('username', with: '1234')
    click_button('Save Score')
    expect(page).to have_table('Records')
  end

end  