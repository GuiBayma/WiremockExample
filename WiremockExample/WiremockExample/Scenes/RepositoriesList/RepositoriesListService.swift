import Foundation

struct RepositoriesListService: NetworkServiceProtocol {
    var path: String {
        return "https://api.github.com/search/repositories?q=language:swift&sort=stars&page=0"
    }

    var method: HttpMethod {
        return .get
    }
}
