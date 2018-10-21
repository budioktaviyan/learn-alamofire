import Foundation

struct HomeParam {

    var request: [String: Any] {
        get { return ["sort_by": "popularity.desc"] }
    }
}
