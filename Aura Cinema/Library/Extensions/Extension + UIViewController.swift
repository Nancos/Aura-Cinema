import UIKit

enum AlertType {
    case timed(time: TimeInterval)
    case standard(buttonTitle: String)
    case standardDefault
}

extension UIViewController {
    @MainActor
    func showAlert(title: String?, message: String?, alertType: AlertType) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }),
              let topVC = keyWindow.rootViewController?.presentedViewController ?? keyWindow.rootViewController
        else { return }
        
        switch alertType {
        case .timed(time: let time):
            topVC.present(alert, animated: true) {
                Task {
                    try await Task.sleep(for: .seconds(Int(time)))
                    alert.dismiss(animated: true)
                }
            }
        case .standard(buttonTitle: let buttonTitle):
            let okAction = UIAlertAction(title: buttonTitle, style: .default)
            alert.addAction(okAction)
            topVC.present(alert, animated: true)
        case .standardDefault:
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            topVC.present(alert, animated: true)
        }
    }
}
