require 'cinch'
require 'video_info'
require 'twitter-text'
require 'uri'
require 'sentry/helper'

module Cinch
  module Plugins
    module Sentry
      class Reddit
        include Cinch::Plugin
        include Twitter::Extractor

        # Fetch all github links
        listen_to :channel

        def initialize(*)
          super
        end

        def listen(m)
          # Exctract urls
          urls = extract_urls(m.message)

          # Go through all links
          urls.each do |url|
            # Parse the url
            uri = URI.parse(URI.escape(url.to_url))

            # We only handle GitHub links
            case uri.host
            when "www.dailymotion.com",
                 "dailymotion.com",
                 "dai.ly",
                 "www.dai.ly",
                 "vimeo.com",
                 "www.vimeo.com",
                 "www.youtube.com",
                 "youtube.com",
                 "youtu.be",
                 "www.youtu.be"
              begin
                # Get information from the link
                video = VideoInfo.new(uri.to_s, "User-Agent" => "Sentry IRC Bot/0.1.0")

                # Check if it is a link to a live video
                if video.duration == 0 and video.provider.eql? "YouTube"
                  m.reply("[%s] %s (%s)" % [
                    Format(:green, info.provider),
                    Format(:bold, info.title),
                    Format(:orange, "LIVE")
                  ])
                else
                  m.reply("[%s] %s (duration: %s)" % [
                    Format(:green, info.provider),
                    Format(:bold, info.title),
                    Format(:teal, ChronicDuration.output(info.duration))
                  ])
                end
              rescue Exception => e
                # Log the exception
                puts e
              end
            end
          end
        end
      end
    end
  end
end