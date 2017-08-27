Pod::Spec.new do |s|
  s.name             = 'FAPanels'
  s.version          = '0.2.5'
  s.summary          = 'Swift Panels with Animations'

  s.description      = <<-DESC
Panels support left, right and center containers. Useful to show left and right side menus
                       DESC

  s.homepage         = 'https://github.com/fahidattique55/FAPanels'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { 'Fahid Attique' => 'fahidattique55@gmail.com' }
  s.source           = { :git => 'https://github.com/fahidattique55/FAPanels.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'FAPanels/Classes/**/*.{swift}'

end
