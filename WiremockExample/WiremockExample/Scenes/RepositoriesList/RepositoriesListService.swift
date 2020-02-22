import Foundation

struct RepositoriesListService: NetworkServiceProtocol {
    var path: String {
        return "\(baseUrl)/search/repositories"
    }

    var method: HttpMethod {
        return .get
    }

    var queryItems: [URLQueryItem]? {
        let language = URLQueryItem(name: "q", value: "language:swift")
        let sort = URLQueryItem(name: "sort", value: "stars")
        let page = URLQueryItem(name: "page", value: "0")
        return [language, sort, page]
    }
}
