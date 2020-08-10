//
//  LocationManager.swift
//  TokenBook
//
//  Created by 小唐 on 2018/10/15.
//  Copyright © 2018 ZhiYiCX. All rights reserved.
//
//  定位管理
//  暂时只做高德定位的基本封装，之后可考虑进一步封装，也可考虑对百度地图的集成进行封装
/**
 关于定位获取的说明，使用startLocation比getCurrentLocation速度快很多。
 
 **/

import Foundation
import AMapFoundationKit

protocol LocationManagerProtocol: class {
    /// 定位授权状态回调
    func locationManager(_ manager: LocationManager, didChange status: CLAuthorizationStatus)
    /// POI搜索 + 逆地理编码结束回调
    func locationManager(_ manager: LocationManager, onPOISearchDone request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!)
    /// 定位更新
    func locationManager(_ manager: LocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!)
}
extension LocationManagerProtocol {
    /// POI搜索 + 逆地理编码结束回调
    func locationManager(_ manager: LocationManager, onPOISearchDone request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {

    }
    /// 定位更新
    func locationManager(_ manager: LocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {

    }
}

class LocationManager: NSObject {
    static let defaultLocationTimeout: Int = 5
    static let defaultReGeocodeTimeout: Int = 5

    /// 定位超时时间
    var locationTimeout = LocationManager.defaultLocationTimeout
    /// 逆地理请求超时时间
    var reGeocodeTimeout = LocationManager.defaultReGeocodeTimeout

    fileprivate(set) var currentLocation: CLLocation?
    fileprivate(set) var currentReGeocode: AMapLocationReGeocode?

    weak var delegate: LocationManagerProtocol?

    /// 添加默认实例，但非单例
    static let `default` = LocationManager()
    override init() {
        super.init()
        self.configLocationManager()
        self.configPOISearch()
    }

    /// 三方POI Search
    fileprivate var mapSearch: AMapSearchAPI?
    /// 三方定位控制器
    fileprivate lazy var locationManager = AMapLocationManager()

}

// MARK: - Config Function
extension LocationManager {
    /// 定位配置 - 顺带判断定位权限状态
    fileprivate func configLocationManager() {
        locationManager.delegate = self
        /// 推荐精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        /// 定位超时时间
        locationManager.locationTimeout = self.locationTimeout
        /// 逆地理请求超时时间
        locationManager.reGeocodeTimeout = self.reGeocodeTimeout
    }

    /// POI配置
    fileprivate func configPOISearch() -> Void {
        // 构造 AMapSearchAPI
        let search = AMapSearchAPI()
        search?.delegate = self
        self.mapSearch = search
    }
}

// MARK: - Internal Function
extension LocationManager {
    /// 去系统设置页开启定位
    func openSystemSettingForLocation() -> Void {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }

    /// 检查定位权限 根据BOOL返回值，是否开始定位
    func checkLocationPermissions() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            return true
        case .denied:
            return false
        case .notDetermined, .restricted:
            return false
        }
    }

    /// 获取当前定位
    /// 调用该方法前建议先检查权限
    func getCurrentLocation(complete: @escaping((_ status: Bool, _ location: CLLocation?, _ reGeocode: AMapLocationReGeocode?, _ error: Error?) -> Void)) -> Void {
        self.locationManager.requestLocation(withReGeocode: true) { (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            self.currentLocation = nil
            if let error = error {
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加

                    //self?.locationLabel.text = "三方定位错误"
                    //self?.finishBlock?(nil)
                    //self?.showImageOrAnmie(show: .Iamge)
                    complete(false, nil, nil, error)
                    return
                } else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    //self?.locationLabel.text = "三方逆地理错误"
                    //self?.finishBlock?(nil)
                    //self?.showImageOrAnmie(show: .Iamge)
                    complete(true, location, reGeocode, error)
                }
            }
            print(location as Any)
            print(reGeocode as Any)
            complete(true, location, reGeocode, error)
            self.currentLocation = location
            if let location = location {
                self.locationAroundPOIRequest(location: location, keyword: nil)
            }
        }
    }

    /// 周边搜索
    func locationAroundPOIRequest(location: CLLocation, keyword: String?) -> Void {
        // 设置周边检索的参数
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.coordinate.latitude), longitude: CGFloat(location.coordinate.longitude))
        if let keyword = keyword {
            request.keywords = keyword
        }
        request.requireExtension = true
        // 发起周边检索
        self.mapSearch?.aMapPOIAroundSearch(request)
    }
    /// 关键字搜索
    func keywordPOIRequest(_ keyword: String) -> Void {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(self.currentLocation?.coordinate.latitude ?? 0), longitude: CGFloat(self.currentLocation?.coordinate.longitude ?? 0))
        request.keywords = keyword
        request.requireExtension = true
        // 发起周边检索
        self.mapSearch?.aMapPOIAroundSearch(request)
        // 设置关键字检索的参数
//        let request = AMapPOIKeywordsSearchRequest()
//        request.keywords = keyword
//        request.requireExtension = true
//        request.requireSubPOIs = false
//        request.cityLimit = true
//        request.city = self.currentReGeocode?.city
//        // 发起关键字检索
//        self.mapSearch?.aMapPOIKeywordsSearch(request)
    }

}

// MARK: - Extension Function
extension LocationManager {
    func startUpdatingLocation() -> Void {
        self.locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() -> Void {
        self.locationManager.stopUpdatingLocation()
    }
}

// MARK: - Delegate <AMapSearchDelegate>
extension LocationManager: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        self.delegate?.locationManager(self, onPOISearchDone: request, response: response)

//        if response.count == 0 {
//            return
//        }

//        1）可以在回调中解析 response，获取 POI 信息。
//        2）response.pois 可以获取到 AMapPOI 列表，POI 详细信息可参考 AMapPOI 类。
//        3）若当前城市查询不到所需 POI 信息，可以通过 response.suggestion.cities 获取当前 POI 搜索的建议城市。
//        4）如果搜索关键字明显为误输入，则可通过 response.suggestion.keywords法得到搜索关键词建议。

//            self.sourceList.removeAll()
//            for poi in response.pois {
//                self.sourceList.append(poi)
//            }
//            self.tableView.reloadData()
//            self.tableView.mj_header.endRefreshing()
    }

    func amapLocationManager(_ manager: AMapLocationManager!, didFailWithError error: Error!) {

    }
}

// MARK: - Delegate <AMapLocationManagerDelegate>
extension LocationManager: AMapLocationManagerDelegate {

    /// 定位授权状态回调方法
    func amapLocationManager(_ manager: AMapLocationManager!, didChange status: CLAuthorizationStatus) {
        self.delegate?.locationManager(self, didChange: status)

//        switch status {
//        case .authorizedWhenInUse:
//            fallthrough
//        case .authorizedAlways:
//            self.getCurrentLocation()
//        case .notDetermined:
//            return
//        default:
//            let appName = TSAppConfig.share.localInfo.appDisplayName
//            TSErrorTipActionsheetView().setWith(title: "定位权限设置", TitleContent: "请为\(appName)开放定位权限：手机设置-隐私-定位-\(appName)(打开)", doneButtonTitle: ["去设置", "取消"], complete: { (_) in
//                let url = URL(string: UIApplicationOpenSettingsURLString)
//                if UIApplication.shared.canOpenURL(url!) {
//                    UIApplication.shared.openURL(url!)
//                }
//            })
//        }
    }

    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        print(location)
        if nil == self.currentLocation {
            self.currentLocation = location
            self.currentReGeocode = reGeocode
        }
        self.delegate?.locationManager(self, didUpdate: location, reGeocode: reGeocode)
    }

}
