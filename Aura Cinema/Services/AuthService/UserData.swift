import Foundation

struct UserData: Identifiable {
    var id: String = UUID().uuidString
    let email: String
    let password: String
    let name: String?
    let surname: String?
}
