Pod::Spec.new do |s|
  s.name         = "LYActivityIndicatorView"
  s.version      = "0.1"
  s.summary      = ""
  s.description  = <<-DESC
                   
                   DESC
  s.homepage     = "https://gitlab.com/nakio/LY-ActivityIndicatorView-iOS.git"
  s.license      = {
		:type => 'MIT',
		:text => <<-LICENSE

		LICENSE
	}
  s.author       = { "Carlos Vidal" => "carlos.vidal.pallin@ly.st" }
  s.source       = { :git => "git@gitlab.com:nakio/LY-ActivityIndicatorView-iOS.git", :branch => "master" }
  s.platform     = :ios, '7.0'
  s.source_files = 'LYActivityIndicatorView/*.{h,m}'
  s.public_header_files = 'LYActivityIndicatorView.h'
  s.requires_arc = true
  s.frameworks = 'QuartzCore', 'Foundation', 'UIKit', 'CoreGraphics'
end
