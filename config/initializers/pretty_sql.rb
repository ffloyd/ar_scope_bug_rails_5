require 'anbt-sql-formatter/formatter'

class String
  def pp_sql
    rule = AnbtSql::Rule.new
    formatter = AnbtSql::Formatter.new(rule)
    puts formatter.format(self)
  end
end
