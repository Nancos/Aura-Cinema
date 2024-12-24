import UIKit

final class CustomImageView: UIImageView {
    var urlString: String? {
        didSet {
            guard let urlString else { return }
            self.kf.setImage(with: URL(string: urlString),
                             placeholder: nil,
                             options: [.transition(.fade(0.4))])
        }
    }
}
