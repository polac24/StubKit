Pod::Spec.new do |s|
  s.name             = 'StubKit'
  s.version          = '0.0.7'
  s.summary          = 'Library for Swift mocks/stubs generation'
  s.swift_version    = '4.2'
  s.description      = <<-DESC
StubKit provides a set of functions that speed up a process of creation of Swift stubs/mocks. It's goal is to require minimal amount of developer's work in mock creation while  leveraging Swift's type system type integrity for safety without meta programming nor any code-generation.
                       DESC

  s.homepage         = 'https://github.com/polac24/StubKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'polac24' => 'polac24@gmail.com' }
  s.source           = { :git => 'https://github.com/polac24/StubKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/norapsi'

  s.ios.deployment_target = '8.0'

  s.source_files = 'StubKit/Classes/**/*'
  s.frameworks = 'XCTest'
end
