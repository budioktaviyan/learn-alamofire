import Foundation

struct HomeParam {

    var page: Int64 = 1

    var request: [String: Any] {
        get {
            return [
                "page": page,
                "api_key": AppConfig.Api.Key,
                "sort_by": "popularity.desc"
            ]
        }
    }
}
