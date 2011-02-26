require 'rubygems/test_case'
require 'rubygems/commands/tldr_command'

class TestGemCommandsTldrCommand < Gem::TestCase

  def setup
    super

    @cmd = Gem::Commands::TldrCommand.new
  end

  def test_strip_comments
    ruby = <<-'RUBY'
# comment for C
class C

  # comment for m
  def m # :yields: something
    puts "hello #{world}"
  end

end
    RUBY

    @cmd.strip_comments ruby

    expected = <<-'EXPECTED'
class C

  def m
    puts "hello #{world}"
  end

end
    EXPECTED

    assert_equal expected, ruby
  end

end

