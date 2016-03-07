# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf

Rack::Mime::MIME_TYPES['.otf']  = 'application/x-font-opentype'
Rack::Mime::MIME_TYPES['.woff'] = 'application/x-font-woff'
Rack::Mime::MIME_TYPES['.eot']  = 'application/vnd.ms-fontobject'
Rack::Mime::MIME_TYPES['.ttf']  = 'application/x-font-ttf'
Rack::Mime::MIME_TYPES['.svg']  = 'image/svg+xml'