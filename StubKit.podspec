#
# Be sure to run `pod lib lint StubKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StubKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of StubKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/polac24/StubKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'polac24' => 'polac24@gmail.com' }
  s.source           = { :git => 'https://github.com/polac24/StubKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/norapsi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'StubKit/Classes/**/*'
  s.frameworks = 'XCTest'
  
  # s.resource_bundles = {
  #   'StubKit' => ['StubKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.dependency 'AFNetworking', '~> 2.3'
end
