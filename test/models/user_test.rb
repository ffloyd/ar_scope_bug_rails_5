require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'scope #with_role works' do
    assert_equal User.with_role('tenderlover'), [users(:aaron)]
  end

  test 'scope #useless_join works' do
    assert_equal User.useless_join.to_a, User.all.to_a
  end

  test 'scope chain "useless_join -> with_role" works' do
    assert_equal User.useless_join.with_role('tenderlover'), [users(:aaron)]
  end

  # there bug revealed
  test 'scope chain "with_role -> useless_join" works' do
    assert_equal User.with_role('tenderlover').useless_join, [users(:aaron)]
  end

  # but there is no bug Oo
  test 'scope #with_role works with complex join from #useless_join when it constructed outside model' do
    subquery_sql = User.select('users.id AS user_id').to_sql
    subject = User
              .with_role('tenderlover')
              .joins("INNER JOIN (#{subquery_sql}) subquery ON subquery.user_id = users.id")
    assert_equal subject, [users(:aaron)]
  end
end
