require 'hominid'

module Devise
  module Models
    module Mailchimp
      class MailchimpListApiMapper
        LIST_CACHE_KEY = "devise_mailchimp/lists"

        # craete a new ApiMapper with the provided API key
        def initialize(api_key, double_opt_in)
          @api_key = api_key
          @double_opt_in = double_opt_in
        end

        # looks the name up in the cache.  if it doesn't find it, looks it up using the api and saves it to the cache
        def name_to_id(list_name)
          load_cached_lists
          if @lists.has_key?(list_name)
            return @lists[list_name]
          else
            list_id = hominid.find_list_id_by_name(list_name)
            if list_id.nil?
              raise ListLookupError
            else
              @lists[list_name] = list_id
              save_cached_lists
              return @lists[list_name]
            end
          end
        end

        # subscribes the user to the named mailing list(s).  list_names can be the name of one list, or an array of
        # several.
        #
        # NOTE: Do not use this method unless the user has opted in.
        def subscribe_to_lists(list_names, email)
          list_names = [list_names] unless list_names.is_a?(Array)
          list_names.each do |list_name|
            list_id = name_to_id(list_name)
            hominid.list_subscribe(list_id, email, {}, 'html', @double_opt_in, true, true, false)
          end
        end

        # unsubscribe the user from the named mailing list(s).  list_names can be the name of one list, or an array of
        # several.
        def unsubscribe_from_lists(list_names, email)
          list_names = [list_names] unless list_names.is_a?(Array)
          list_names.each do |list_name|
            list_id = name_to_id(list_name)
            hominid.list_unsubscribe(list_id, email, false, false, false)
            # don't delete, send goodbye, or send notification
          end
        end


        class ListLookupError < RuntimeError; end

        private

        # load the list from the cache
        def load_cached_lists
          @lists ||= Rails.cache.fetch(LIST_CACHE_KEY) do
            {}
          end.dup
        end

        # save the modified list back to the cache
        def save_cached_lists
          Rails.cache.write(LIST_CACHE_KEY, @lists)
        end

        # the hominid api helper
        def hominid
          Hominid::API.new(@api_key)
        end
      end
    end
  end
end
