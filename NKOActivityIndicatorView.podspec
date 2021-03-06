Pod::Spec.new do |s|
  s.name         = "NKOActivityIndicatorView"
  s.version      = "0.3.1"
  s.summary      = "A Lyst.com lookalike activity indicator for iOS"
  s.homepage     = "https://github.com/nakiostudio/NKOActivityIndicatorView-iOS"
  s.license      = {
		:type => 'MIT',
		:text => <<-LICENSE
		Copyright (C) 2016 Carlos Vidal
		Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
		The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE
		LICENSE
	}
  s.author       = { "Carlos Vidal" => "nakioparkour@gmail.com" }
  s.source       = { :git => "https://github.com/nakiostudio/NKOActivityIndicatorView-iOS.git", :tag => s.version }
  s.ios.deployment_target = '7.0'
  s.tvos.deployment_target = '9.0'
  s.source_files = 'NKOActivityIndicatorView/Classes/*.{h,m}'
  s.public_header_files = 'NKOActivityIndicatorView/Classes/*.h'
  s.requires_arc = true
  s.frameworks = 'QuartzCore', 'Foundation', 'UIKit', 'CoreGraphics'
end
