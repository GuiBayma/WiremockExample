import UIKit

final class RepositoriesListViewController: UIViewController {

    private let repositoriesView = RepositoriesListView()
    private let network: NetworkProtocol = Network()

    override func loadView() {
        view = repositoriesView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        repositoriesView.showLoadingState()

        network.request(RepositoriesListService()) { [weak self] result in
            self?.repositoriesView.stopAnimating()

            switch result {
            case .success(let data):
                self?.handleSuccess(data)
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }

    private func handleSuccess(_ data: Data) {}

    private func handleError(_ apiError: ApiError) {}
}
