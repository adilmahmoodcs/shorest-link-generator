# create first 60 Short links
(1..60).to_a.each { |s| ShortLink.create({original_url: "https://google.com"}) }