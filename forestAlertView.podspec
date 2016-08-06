
Pod::Spec.new do |s|
  s.name             = 'forestAlertView'
  s.version          = '0.1.0'
  s.summary          = 'just testing'


  s.description      = <<-DESC
    A short description of forestAlertView
                       DESC

  s.homepage         = 'https://github.com/forestfsl/forestAlertView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fengsonglin' => 'fengsonglin@139.com' }
  s.source           = { :git => 'https://github.com/forestfsl/forestAlertView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'forestAlertView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'forestAlertView' => ['forestAlertView/Assets/*.png']
  # }

#s.public_header_files = 'forestAlertView/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 2.5'
   s.dependency 'FMDB', '~> 2.4'
   s.dependency 'SSKeychain', '~> 1.2.3'
end
