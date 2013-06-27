Pod::Spec.new do |s|
  s.name         = "PlexKit"
  s.version      = "0.0.1"
  s.summary      = "A bunch of often used utility functions/classes."
  s.author       = { "Till Hagger" => "till.hagger@gmail.com" }
  s.source       = { :git => "https://github.com/per2plex/PlexKit", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'PlexKit', 'PlexKit/**/*.{h,m}'

  s.framework  = 'UIKit'
 
  s.requires_arc = true
end
