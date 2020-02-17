import UIKit

final class RepositoriesListViewController: UIViewController {

    private let repositoriesView = RepositoriesListView()
    private let network: NetworkProtocol = Network()
    private var repositories: [Repository] = []

    override func loadView() {
        view = repositoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        repositoriesView.setTableView(dataSource: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repositoriesView.showLoadingState()

        network.request(responseType: RepositoriesResponse.self, RepositoriesListService()) { [weak self] result in
            self?.repositoriesView.stopAnimating()

            switch result {
            case .success(let response):
                self?.handleSuccess(response.items)
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }

    private func handleSuccess(_ repositories: [Repository]) {
        self.repositories = repositories
        repositoriesView.reloadTableView()
    }

    private func handleError(_ apiError: ApiError) {
        print(apiError.error)
        print(String(data: apiError.data ?? Data(), encoding: .utf8) ?? "")
    }
}

extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath)
        if let repositoryCell = cell as? RepositoryTableViewCell {
            repositoryCell.show(model: repositories[indexPath.row])
            return repositoryCell
        }
        return cell
    }
}
