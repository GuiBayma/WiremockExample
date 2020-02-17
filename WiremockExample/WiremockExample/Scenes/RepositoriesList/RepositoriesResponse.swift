import Foundation

struct RepositoriesResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let description: String?
}

struct Owner: Decodable {
    let avatarUrl: String
    let login: String
}
