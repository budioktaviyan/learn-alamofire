import Foundation

struct HomeResponse: Codable {

    var results: [Result]?
    var total_pages: Int64?

    struct Result: Codable {

        var title: String?
        var overview: String?
        var backdrop_path: String?
    }
}
