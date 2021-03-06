require 'test_helper'

class EntriesInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "entry interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Entry.count' do
      post entries_path, entry: { title: "", content: "" }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    content = "This entry really ties the room together"
    title = "Title"
    assert_difference 'Entry.count', 1 do
      post entries_path, entry: { title: title, content: content }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_entry = @user.entries.paginate(page: 1).first
    assert_difference 'Entry.count', -1 do
      delete entry_path(first_entry)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
