target :'MyProject' do

platform :ios, '9.0'

inhibit_all_warnings!


pod 'MBProgressHUD', '~> 1.1.0'
pod 'Bugly', '~> 2.5.0'
pod 'MJRefresh', '~> 3.2.0'
pod 'SDAutoLayout', '~> 2.2.1' #布局库
pod 'SVProgressHUD', '~> 2.2.5'
pod 'Masonry', '~> 1.1.0'
pod 'FDFullscreenPopGesture', '~> 1.1'
pod 'MJExtension', '~> 3.1.2'
pod 'AFNetworking', '~> 3.2.1'

pod 'mob_sharesdk'
pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull' # 带微信支付的

# 解决第三方警告：The iOS deployment target is set to 8.0, but the range of supported deployment target versions for this platform is 9.0 to 13.2.3
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '7.0'
        end
    end
end

end
