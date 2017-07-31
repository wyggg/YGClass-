Pod::Spec.new do |s|
s.name         = "YGClass++"
s.version      = "0.0.1"
s.summary      = "工具类"
s.homepage     = "https://github.com/wyggg/YGClass-.git"
s.license      = "MIT"
s.author             = { "WYG" => "773678819@qq.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/wyggg/YGClass-.git", :tag => "0.0.1" }
s.source_files  = "YGClass++", "YGClass++/YGClass++/YGClass/*.{h,m}"
# s.framework  = "UIKit"
s.dependency = "Masonry", "~> 1.0.2"
