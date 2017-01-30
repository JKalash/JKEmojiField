Pod::Spec.new do |s|

  s.name         = "JKEmojiField"
  s.version      = "0.1.1"
  s.summary      = "A UITextField subclass that forces emoji keyboard and text."
  s.requires_arc = true

  s.description  = <<-DESC
Swift UITextField subclass emoji keyboard cehcks for emoji text attributes and forces emoji keyboard with option of limiting to one emoji only
                   DESC

s.homepage = "https://github.com/jkalash"
  s.screenshots  = "https://s27.postimg.org/saa6okk8j/1.png", "https://s27.postimg.org/jgja7gx9v/2.png", "https://s27.postimg.org/aa0zk6s1f/3.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Joseph Kalash" => "joseph@stalkie.co" }
  s.social_media_url   = "http://twitter.com/JKalash"
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.source       = { :git => "https://github.com/JKalash/JKEmojiField.git", :tag => "#{s.version}" }
  s.source_files  = "JKEmojiField/**/*.{swift}"
  s.framework  = "UIKit"

end
