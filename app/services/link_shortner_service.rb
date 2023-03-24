class LinkShortnerService

  URL_SAFE_CHARS = ("0".."9").to_a.concat(("a".."z").to_a)

  def self.call
    new.call
  end
  
  def call
    last_record = ShortLink.last
    return URL_SAFE_CHARS[0] if last_record.blank? || last_record.shortner_path.blank?
    
    last_record.with_lock do
      
      key_chars = last_record.shortner_path.chars
      x = key_chars.length - 1

      while(x > -1 && key_chars[x] == URL_SAFE_CHARS[-1])
        x = x - 1
      end
      
      change_char = key_chars[x]
      no_of_chars_change = (key_chars.length) - x
      key_chars.pop(no_of_chars_change)

      if URL_SAFE_CHARS.find_index(change_char) != URL_SAFE_CHARS.length - 1
        key_chars.push(URL_SAFE_CHARS[URL_SAFE_CHARS.find_index(change_char) + 1])
        no_of_chars_change = no_of_chars_change - 1
      end

      for i in 1..(no_of_chars_change) do
        key_chars.push(URL_SAFE_CHARS[0])
      end
      key_chars.join
    end
    
  end
end
