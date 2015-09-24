require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'scope #with_role works' do
    assert_array_match User.with_role('tenderlover'), [users(:aaron)]
    assert_array_match User.with_role('maintainer'), [users(:aaron), users(:dhh)]
  end

  test 'scope unscope_via_all works' do
    assert_array_match User.unscope_via_all, User.all
  end

  test 'scope unscope_via_all_as_class_method works' do
    assert_array_match User.unscope_via_all_as_class_method, User.all
  end

  # BUG #1 - dirty state of User.current_scope inside scope lambda context
  test 'scope chain "with_role -> unscope_via_all" works' do
    assert_array_match User.with_role('tenderlover').unscope_via_all, User.all
  end

  # BUG #2 - dirty state of User.current_scope inside class method context
  test 'chain "with_role -> unscope_via_all_as_class_method" works' do
    assert_array_match User.with_role('tenderlover').unscope_via_all_as_class_method, User.all
  end

  # BUG #3 - invalid SQL constructed (maybe not a bug)
  test 'complex query with custom joins based on #with_role' do
    subquery_sql = User.with_role('tenderlover').select('users.id AS user_id').to_sql
    subject = User.with_role('maintainer').joins("INNER JOIN (#{subquery_sql}) subquery ON subquery.user_id = users.id")

    assert_array_match subject, [users(:aaron)]
  end
end
