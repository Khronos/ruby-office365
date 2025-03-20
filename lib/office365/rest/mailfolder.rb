# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Mailfolder
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # mailbox uuid will return messages in that mailbox
      # response { results: [], next_link: '...' }
      def mailfolders(args = {})
	mailbox = args.delete(:mailbox)
	if mailbox
          wrap_results(args.merge(kclass: Models::Mailbox, base_uri: "/me/mailfolders/#{mailbox}/messages"))
	else
          wrap_results(args.merge(kclass: Models::Mailfolder, base_uri: "/me/mailfolders"))
        end
      end
    end
  end
end
