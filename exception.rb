class Exception
  def self.===(exception)
    # rescue all exceptions with messages starting with FOOBAR
    exception.message =~ /^AGAIN/
  end
end
