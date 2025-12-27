import UIKit

final class CarnetHeaderCell: UITableViewCell {

    static let identifier = "CarnetHeaderCell"

    @IBOutlet private weak var gradientView: GradientView!
    @IBOutlet private weak var cloudsImageView: UIImageView!

    @IBOutlet private weak var avatarGradientView: AvatarGradientView!
    @IBOutlet private weak var strokeView: StrokeView!
    @IBOutlet private weak var avatarImageView: UIImageView!

    @IBOutlet private weak var foregroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        cloudsImageView.contentMode = .scaleAspectFill
        cloudsImageView.clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        avatarImageView.layer.cornerRadius =
            avatarImageView.bounds.width / 2
        avatarImageView.clipsToBounds = true

        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor =
            UIColor.systemBackground.cgColor
    }

    func configure(
        avatar: UIImage?,
        foreground: UIImage?,
        clouds: UIImage?
    ) {
        avatarImageView.image = avatar
        foregroundImageView.image = foreground
        cloudsImageView.image = clouds
    }
}
