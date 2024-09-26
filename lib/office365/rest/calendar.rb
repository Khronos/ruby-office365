# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Calendar
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def calendars(args = {})
        wrap_results(args.merge(kclass: Models::Calendar, base_uri: "/me/calendars"))
      end

      # params: args => { StartDateTime: "<iso8601 DateTime>", EndDateTime: "<iso8601 DateTime>" }
      def calendar_view(args = {})
        raise ArgumentError, "StartDateTime and EndDateTime must be provided" unless (args.has_key?(:next_link) && !args[:next_link].blank?) ||
                                                                                     (args.has_key?(:StartDateTime) && args.has_key?(:EndDateTime))
        wrap_results(args.merge(kclass: Models::Event, base_uri: ['/me/calendar', 'calendarView'].join("/")))
      end
    end
  end
end
