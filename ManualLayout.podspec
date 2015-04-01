Pod::Spec.new do |s|
  s.name         = "ManualLayout"
  s.version      = "0.4.2"
  s.summary      = "Easily layout your UIs in code"
  s.homepage     = "https://github.com/Patreon/ManualLayout"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Sam Morrison" => "sam@sam.vg" }
  s.source       = { :git => "https://github.com/Patreon/ManualLayout.git",
		                 :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'ManualLayout/*.{h,m}'
  s.ios.deployment_target = "7.1"
end