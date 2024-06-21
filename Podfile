# https://github.com/CocoaPods/CocoaPods/issues/4585
platform :ios, '17.0'

workspace 'QRISApp'

target 'QRISApp' do
  use_frameworks!

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
end

target 'FeatureHome' do
  project 'FeatureHome/FeatureHome.xcodeproj'
end

target 'QRISCore' do
  project 'QRISCore/QRISCore.xcodeproj'
end
