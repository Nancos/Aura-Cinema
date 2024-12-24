import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    static let shared = AuthService()
    
    func createNewUser(user: UserData, completion: @escaping (Result<Bool, SignInError>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let self = self else { return }
            
            guard error == nil else {
                completion(.failure(.unknowError))
                return
            }
            result?.user.sendEmailVerification()
            
            guard let uid = result?.user.uid else { return }
            
            setUserData(user: user, userID: uid, completion: { _ in })
            
            signOut()
            completion(.success(true))
        }
    }
    
    private func setUserData(user: UserData, userID: String, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("users")
            .document(userID)
            .setData([
                "name": user.name ?? "",
                "surname": user.surname ?? "",
                "email": user.email]) { error in
                    guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
    }
    
    func signIn(user: UserData, completion: @escaping (Result<Bool, SignInError>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let `self` else { return }
            
            guard error == nil else {
                completion(.failure(.unknowError))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(.invalidUser))
                return
            }
            
            if !user.isEmailVerified {
                completion(.failure(.notVerification))
                result?.user.sendEmailVerification()
                signOut()
                return
            }
            
            completion(.success(true))
        }
    }
    
    func isLogin() async -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}

enum SignInError: Error {
    case invalidUser
    case notVerification
    case unknowError
    
    func localizedDescription() -> String {
        switch self {
            case .invalidUser: return String(localized: "error_invalid_user")
            case .notVerification: return String(localized: "error_not_verified")
            case .unknowError: return String(localized: "error_unknown")
        }
    }
}
