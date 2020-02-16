import Foundation

protocol NetworkProtocol {
    func request(_ service: NetworkServiceProtocol, completion: ((Result<Data, ApiError>) -> Void)?)
}

extension NetworkProtocol {
    func request<T: Decodable>(responseType: T.Type, _ service: NetworkServiceProtocol, completion: ((Result<T, ApiError>) -> Void)?) {

        self.request(service) { result in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let data):
                guard let object = try? JSONDecoder().decode(T.self, from: data) else {
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
}
