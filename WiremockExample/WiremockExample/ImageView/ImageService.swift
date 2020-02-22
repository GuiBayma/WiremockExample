import Foundation

struct ImageService: NetworkServiceProtocol {
    let path: String

    var method: HttpMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }
}
