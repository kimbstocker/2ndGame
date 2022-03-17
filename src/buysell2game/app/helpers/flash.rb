def now
    @now ||= FlashNow.new(self)
end