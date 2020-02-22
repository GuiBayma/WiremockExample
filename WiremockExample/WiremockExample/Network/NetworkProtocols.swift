import Foundation

protocol NetworkProtocol {
    func request(_ service: NetworkServiceProtocol, completion: ((Result<Data, ApiError>) -> Void)?)
}

extension NetworkProtocol {
    func request<T: Decodable>(responseType: T.Type, _ service: NetworkServiceProtocol, completion: ((Result<T, ApiError>) -> Void)?) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        self.request(service) { result in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let data):
                guard let object = try? decoder.decode(T.self, from: data) else {
                    completion?(.failure(ApiError(error: .unableToDecode)))
                    return
                }
                completion?(.success(object))
            }
        }
    }
}

enum HttpMethod: String {
    case get = "GET"
}

protocol NetworkServiceProtocol {
    var path: String { get }
    var method: HttpMethod { get }
    var queryItems: [URLQueryItem]? { get }
}

extension NetworkServiceProtocol {
    var baseUrl: String {
        let bundle = Assets.getBundle()
        guard let baseUrl = bundle.infoDictionary?["BASE_URL"] as? String else {
            fatalError("Could not resolve BASE_URL")
        }
        return baseUrl
    }
}
