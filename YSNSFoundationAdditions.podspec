Pod::Spec.new do |s|
  s.name = 'YSNSFoundationAdditions'
  s.version = '0.0.20'
  s.summary = 'Foundation framework categories.'
  s.homepage = 'https://github.com/yusuga/YSNSFoundationAdditions'
  s.license = 'MIT'
  s.author = 'Yu Sugawara'
  s.source = { :git => 'https://github.com/yusuga/YSNSFoundationAdditions.git', :tag => s.version.to_s }
  s.platform = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source_files = 'Classes/YSNSFoundationAdditions/*.{h,m}'
  s.requires_arc = true
end