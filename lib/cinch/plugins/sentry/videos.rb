require 'cinch'
require 'video_info'
require 'twitter-text'
require 'uri'
require 'chronic_duration'
require 'sentry/helper'

module Cinch
  module Plugins
    module Sentry
      class Videos
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

          # Set the API keys
          VideoInfo.provider_api_keys = {
            youtube: config["youtube"],
            vimeo: config["vimeo"]
          }

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
                    Format(:green, video.provider),
                    Format(:bold, video.title),
                    Format(:orange, "LIVE")
                  ])
                else
                  m.reply("[%s] %s (duration: %s)" % [
                    Format(:green, video.provider),
                    Format(:bold, video.title),
                    Format(:teal, ChronicDuration.output(video.duration))
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