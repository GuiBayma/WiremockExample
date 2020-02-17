import UIKit

final class LoadableImageView: UIImageView {

    private let network: NetworkProtocol = Network()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        return activityIndicator
    }()

    override init(image: UIImage? = nil) {
        super.init(image: image)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        contentMode = .scaleAspectFill
        layer.cornerRadius = 30
        clipsToBounds = true
        backgroundColor = .lightGray
    }

    func setImage(from urlString: String) {
        activityIndicator.startAnimating()

        network.request(ImageService(path: urlString)) { [weak self] result in
            self?.activityIndicator.stopAnimating()
            self?.handleResult(result)
        }
    }

    private func handleResult(_ result: Result<Data, ApiError>) {
        if case let Result.success(data) = result {
            image = UIImage(data: data)
        }
    }
}
