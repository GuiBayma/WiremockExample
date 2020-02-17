import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private let ownerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()

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
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: ownerNameLabel.bottomAnchor, multiplier: margin),
            descriptionLabel.trailingAnchor.constraint(equalTo: repositoryNameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -margin)
        ])

        backgroundColor = .clear
        layer.cornerRadius = 4
    }
}
