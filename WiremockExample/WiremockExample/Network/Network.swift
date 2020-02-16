import Foundation

final class Network: NetworkProtocol {

    private let successCodes: Range<Int> = 200..<299

    private let sessionConfig: URLSessionConfiguration = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15
        return sessionConfig
    }()

    private lazy var urlSession = URLSession(configuration: sessionConfig)

    func request(_ service: NetworkServiceProtocol, completion: ((Result<Data, ApiError>) -> Void)?) {
        guard let urlRequest = configureUrlRequest(with: service) else {
            completion?(.failure(ApiError(error: .badURL)))
            return
        }
        execute(request: urlRequest, completion: completion)
    }

    private func configureUrlRequest(with service: NetworkServiceProtocol) -> URLRequest? {
        guard let url = URL(string: service.path) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = service.method.rawValue
        return urlRequest
    }

    private func execute(request: URLRequest, completion: ((Result<Data, ApiError>) -> Void)?) {

        let dataTask = urlSession.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.handle(data: data, response: response, error: error, completion: completion)
            }
        }

        DispatchQueue.global().async {
            dataTask.resume()
        }
    }

    private func handle(data: Data?, response: URLResponse?, error: Error?, completion: ((Result<Data, ApiError>) -> Void)?) {
        guard let response = response as? HTTPURLResponse else {
            completion?(.failure(ApiError(error: .badResponse)))
            return
        }

        guard self.successCodes.contains(response.statusCode) else {
            completion?(.failure(ApiError(error: .failed(error: error), statusCode: response.statusCode, data: data)))
            return
        }

        completion?(.success(data ?? Data()))
    }
}
