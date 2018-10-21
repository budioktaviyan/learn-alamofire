import Foundation
import Alamofire

extension JSONDecoder {

    func decodeResponse<T: Codable>(from response: DataResponse<Data>) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }

        guard let data = response.data else {
            print(response.error!)
            return .failure(response.error!)
        }

        do {
            let result = try decode(T.self, from: data)
            return .success(result)
        } catch {
            print(error)
            return .failure(error)
        }
    }
}
