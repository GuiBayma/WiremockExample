import Foundation

struct ApiError: Error {
    var error: NetworkError
    var statusCode: Int?
    var data: Data?

    init(error: NetworkError, statusCode: Int? = nil, data: Data? = nil) {
        self.error = error
        self.statusCode = statusCode
        self.data = data
    }
}

enum NetworkError {
    case badURL
    case badResponse
    case unableToDecode
    case failed(error: Error?)
}
