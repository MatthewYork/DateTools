Pod::Spec.new do |s|
  s.name         = 'DateToolsSwift'
  s.version      = '4.0.0'
  s.summary      = 'Dates and time made easy in Swift'
  s.homepage     = 'https://github.com/MatthewYork/DateTools'

  s.description  = 'DateTools was written to streamline date and time handling in Swift.'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Matthew York" => "my3681@gmail.com" }

  s.source       = { :git => "https://github.com/MatthewYork/DateTools.git",
                     :tag => "#{s.version.to_s}" }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.requires_arc = true

  s.source_files = 'DateToolsSwift/DateTools'
  s.resources    = 'DateToolsSwift/DateTools/DateTools.bundle'
end
