## How to use?


```
import ObjectMapper

class TSAdvertSpaceModel: Mappable {
    
    // 广告位的位置类型
    var space: String = ""
    // 广告位 id 数据
    var id: Int = 0
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        space <- map["space"]
        id <- map["id"]
    }
    
}


static let adRequestInfo = RequestInfo<TSAdvertSpaceModel>(method: .get, path: "advertisingspace", replaceds: [])
//static let adRequestInfo = RequestInfo<Empty>(method: .get, path: "advertisingspace", replaceds: [])

func networkTest() -> Void {
    var requestInfo = adRequestInfo
    requestInfo.urlPath = requestInfo.fullPathWith(replacers: [])
    let manager = NetworkManager.share
    manager.request(requestInfo: requestInfo) { (result) in
        switch result {
        case .success(let response):
            print(response)
        case .failure(let response):
            print(response)
        case .error(let error):
            print(error)
        }
    }
}


```

