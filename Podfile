# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

source 'https://github.com/CocoaPods/Specs.git'

target 'CinemaTv' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
#     pod 'Firebase/Core'
#     pod 'Firebase/Auth'
#     pod 'Kingfisher', '~> 6.0'
#     pod 'SnapKit', '~> 5.0.0'
#     pod 'JGProgressHUD'

  # Pods for CinemaTv
    target 'CinemaTvTests' do 
      inherit! :search_paths
      pod 'Nimble-Snapshots'
      pod 'Quick'
      pod 'Nimble'
    end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete ‘IPHONEOS_DEPLOYMENT_TARGET’
    end
  end
  # Este trecho são alterações para rodar no Apple Silicon
  installer.pods_project.build_configurations.each do |config|
      config.build_settings[“EXCLUDED_ARCHS[sdk=iphonesimulator*]“] = “arm64”
    end
end 
