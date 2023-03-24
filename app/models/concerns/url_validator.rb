module UrlValidator
  extend ActiveSupport::Concern

  included do
    # Regex that webhook url must match.
    URL_REGEX = URI::DEFAULT_PARSER.make_regexp(["http", "https"])

    # Hosts that we don't want to make requests to.
    DENIED_HOSTS = %w[].freeze

    validates :original_url, presence: true, format: {with: URL_REGEX}
    validate :url_host

    private
    def url_host
      return if original_url.blank?
      uri = URI(original_url) rescue nil
      if uri.blank? || DENIED_HOSTS.include?(uri.host)
        errors.add(:original_url, I18n.t('errors.url.invalid'))
      end
    end
  end
end