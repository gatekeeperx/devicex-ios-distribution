Pod::Spec.new do |s|
  s.name             = 'Devicex'
  s.version          = '1.0.7'
  s.summary          = 'Framework oficial de Devicex para recolección de métricas y seguridad en iOS.'
  s.homepage         = 'https://github.com/gatekeeperx/devicex-ios-distribution'
  s.license          = { :type => 'Commercial', :text => 'Copyright (c) 2026 GatekeeperX' }
  s.author           = { 'GatekeeperX' => 'contact@gatekeeperx.com' }
  s.source           = { :http => "https://github.com/gatekeeperx/devicex-ios-distribution/releases/download/1.0.7/Devicex.xcframework.zip" }
  
  s.ios.deployment_target = '17.0'
  s.swift_version = '5.0'
  
  s.vendored_frameworks = 'Devicex.xcframework'
end
