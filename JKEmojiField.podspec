Pod::Spec.new do |s|

  s.name         = "JKEmojiField"
  s.version      = "0.1.0"
  s.summary      = "A UITextField subclass that forces emoji keyboard and text."

  s.description  = <<-DESC
Swift UITextField subclass emoji keyboard
                   DESC

  s.screenshots  = "https://s27.postimg.org/saa6okk8j/1.png", "https://s27.postimg.org/jgja7gx9v/2.png", "https://s27.postimg.org/aa0zk6s1f/3.png"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Joseph Kalash" => "joseph@stalkie.co" }
  s.social_media_url   = "http://twitter.com/JKalash"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "http://github.com/JKalash/JKEmojiField.git", :tag => "#{s.version}" }
  s.source_files  = "JKEmojiField/**/*.{swift}"
  s.framework  = "UIKit"

end
