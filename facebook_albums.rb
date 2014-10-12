require 'httparty'
require 'json'

module Jekyll
  class FacebookAlbumTag < Liquid::Tag

    def initialize(tag_name, album, tokens)
      super
      @album = album.strip
    end
    def render(context)
      rendered = ''
      response = HTTParty.get("https://graph.facebook.com/#{@album}?fields=photos")
      album = JSON.parse(response.body)
      album['photos'] && album['photos']['data'].each do |album_image|
        thumb = album_image['picture']
        source = album_image['source']
        rendered += "<a class=\"fancybox fancybox.iframe\" rel=\"group\" href='#{source}'><img src='#{thumb}' alt="" /></a>"
      end # each album_image
      rendered
    end
  end
end

Liquid::Template.register_tag('facebook_album', Jekyll::FacebookAlbumTag)
