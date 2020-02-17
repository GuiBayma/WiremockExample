import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()

    private let ownerImageView = LoadableImageView()

    private let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let ownerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        containerView.addSubview(ownerImageView)
        containerView.addSubview(repositoryNameLabel)
        containerView.addSubview(ownerNameLabel)
        containerView.addSubview(descriptionLabel)
        contentView.addSubview(containerView)

        let margin: CGFloat = 12

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -margin),

            ownerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            ownerImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: margin),
            ownerImageView.heightAnchor.constraint(equalToConstant: 60),
            ownerImageView.widthAnchor.constraint(equalToConstant: 60),

            repositoryNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: margin),
            repositoryNameLabel.topAnchor.constraint(equalTo: ownerImageView.topAnchor),
            repositoryNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -margin),

            ownerNameLabel.leadingAnchor.constraint(equalTo: repositoryNameLabel.leadingAnchor),
            ownerNameLabel.topAnchor.constraint(equalTo: repositoryNameLabel.bottomAnchor, constant: 4),
            ownerNameLabel.trailingAnchor.constraint(equalTo: repositoryNameLabel.trailingAnchor),

            descriptionLabel.leadingAnchor.constraint(equalTo: repositoryNameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: repositoryNameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -margin)
        ])

        selectionStyle = .none
        backgroundColor = .clear
    }

    func show(model: Repository) {
        ownerImageView.setImage(from: model.owner.avatarUrl)
        repositoryNameLabel.text = model.name
        ownerNameLabel.text = model.owner.login
        descriptionLabel.text = model.description
    }
}
