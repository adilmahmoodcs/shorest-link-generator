json.short_link  "#{request.base_url}/#{short_link.shortner_path}"
json.(short_link, :title) if short_link.title.present?
