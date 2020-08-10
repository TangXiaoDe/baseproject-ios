platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

# 通过pod 使用三方库时,必须指定明确的版本号!方便同期开发的用户使用相同的三方,方便后续更新!
# 编辑该文件时,必须使用专业的编辑器.不允许使用记事本编辑,避免导致的乱码错误引发的问题.

target 'BaseProject' do

source 'https://github.com/CocoaPods/Specs.git'
  
# Swift 4
pod 'SnapKit', '4.2.0'                    # UI布局组件, 5.0.0的不支持iOS9；
pod 'Alamofire', '4.8.2'                  # 网络请求，5.0.0的还是beta版；
pod 'Kingfisher', '4.10.1'                # 图片下载缓存转码等，5.0.0及以上的不支持iOS9；
pod 'NVActivityIndicatorView', '4.7.0'    # 加载动画

# Swift (部分版本待定)

# 公司私有组件库
pod 'ChainOneKit-Swift', :git => 'https://github.com/CommunityChain/ChainOneKit-Swift.git', :tag => '0.0.9.1'
#pod 'XiaoDeKit'

pod 'SwiftyJSON', '5.0.0'                 # json 解析
pod 'ObjectMapper', '3.4.2'               # 数据转模型
pod 'CryptoSwift', '1.0.0'                # 加密
pod 'RealmSwift', '3.19.0'                # 本地数据库
pod 'STRegex', '2.1.0'                    # regex 处理
pod 'KeychainAccess', '3.2.0'             # 钥匙串管理
pod 'ReachabilitySwift', '4.3.1'          # 网络连接性检查
pod 'MonkeyKing', '1.15.0'                # 三方分享
pod 'MarkdownView', '1.5.0'               # markdown 渲染器基于 webview
pod 'SwiftLint', '0.32.0'                 # SwiftLint 代码规范


# Objective-C
pod 'YYKit', '1.0.9'                      # iOS 组件
pod 'MJRefresh', '3.2.0'                  # 上下拉刷新
pod 'ZFPlayer', :git => 'https://github.com/TangXiaoDe/ZFPlayer.git', :tag => '2.1.6.4'    # 播放器
#pod 'ZFPlayer', '3.2.12'    # 播放器
#pod 'TZImagePickerController', '3.2.1'    # 视频.图片选择框
pod 'TZImagePickerController', :git => 'https://github.com/TangXiaoDe/TZImagePickerController.git', :tag => '3.2.1.3'    # 视频.图片选择框
pod 'SDCycleScrollView', '1.80'           # 轮播
pod 'SDWebImage', '5.0.2'                 # 图片加载库
pod 'JPush', '3.2.0'                      # 极光推送
pod 'Bugly', '2.5.0'                      # 崩溃收集
pod 'WechatOpenSDK', '1.8.6.2'              # 微信打开回调
pod 'UMCCommon', '2.0.1'                  # UM基础库
pod 'UMCAnalytics', '6.0.3'               # UM统计
pod 'UMCErrorCatch', '1.0.0'              # UM错误分析
pod 'Hyphenate', '3.5.5'                  # 环信sdk
pod 'Masonry'
pod 'MBProgressHUD', '~> 1.1.0'
pod 'AMapLocation', '2.6.3'               # 高德定位
pod 'AMapSearch', '7.1.0'                 # 高德定位搜索
pod 'Qiniu', '~> 7.1'
#pod 'SDWebImage/GIF'
#pod 'FLAnimatedImage', '~> 1.0'


#pod 'AlipaySDK-iOS'                       # 支付宝

  target 'BaseProjectTests' do            # 测试相关三方库
    inherit! :search_paths
    pod 'Nimble', '8.0.1'                   # 断言
    pod 'Mockingjay', '2.0.1'               # 网络请求模拟
    
  end

end
