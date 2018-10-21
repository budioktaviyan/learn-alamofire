import Foundation

struct HomeParam {

    var request: [String: Any] {
        get {
            return [
                "api_key": AppConfig.Api.Key,
                "sort_by": "popularity.desc"
            ]
        }
    }
}
