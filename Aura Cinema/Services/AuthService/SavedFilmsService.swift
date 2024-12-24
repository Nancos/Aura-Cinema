import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol FavoritesUpdateDelegate: UIViewController {
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) async
    func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) async
}

@MainActor
extension FavoritesUpdateDelegate {
     func didUpdateLikedMovies(title: String, message: String, alertType: AlertType) {
        self.showAlert(title: title, message: message, alertType: alertType)
    }
    
    func showErrorFavoritesUpdate(title: String, message: String, alertType: AlertType) {
        self.showAlert(title: title, message: message, alertType: alertType)
    }
}

final class SavedFilmsService {
    
    static let shared = SavedFilmsService()
    
    func addSavedFilms(movie: SavedFilmData, completion: @escaping (Result<Void, LoadFilmsError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(.invalidUser))
            return
        }
        
        // Получение userDocument и проверка ошибки
        let userDocument = Firestore.firestore().collection("users").document(uid)
        
        userDocument.getDocument { snapshot, error in
            if let error {
                completion(.failure(.firestoreError(error)))
                return
            }
            
            // Проверка наличия данных в БД
            guard let snapshot else {
                completion(.failure(.unknownError))
                return
            }
            
            var savedFilmIds = snapshot.data()?["savedFilms"] as? [Int] ?? []
            
            if savedFilmIds.contains(movie.id) {
                // ID существует, удаляем его
                savedFilmIds.removeAll { $0 == movie.id }
                userDocument.updateData(["savedFilms": savedFilmIds]) { error in
                    if let error {
                        completion(.failure(.firestoreError(error)))
                    } else {
                        completion(.failure(.duplicateRemoved))
                    }
                }
            } else {
                // ID не существует, добавляем его
                savedFilmIds.append(movie.id)
                userDocument.updateData(["savedFilms": savedFilmIds]) { error in
                    if let error {
                        completion(.failure(.firestoreError(error)))
                    } else {
                        completion(.success(()))
                    }
                }
            }
        }
    }
    
    func loadSavedFilms(completion: @escaping (Result<[SavedFilmData], LoadFilmsError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(.failure(.invalidUser))
            return
        }
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error {
                    print("error: \(error)")
                    completion(.failure(.unknownError))
                    return
                }
                
                guard let data = snapshot?.data(),
                      let savedFilmIds = data["savedFilms"] as? [Int] else {
                    completion(.success([]))
                    return
                }
                
                let films = savedFilmIds.map { SavedFilmData(id: $0) }
                completion(.success(films))
            }
    }
}


enum LoadFilmsError: Error {
    case invalidUser
    case dataEmpty
    case unknownError
    case duplicateRemoved
    case firestoreError(Error)
}

extension SavedFilmsService {
    func handleError(error: LoadFilmsError) -> (title: String, message: String){
        switch error {
        case .invalidUser:
            return (String(localized: "Error"), String(localized: "error_invalidUser"))
        case .dataEmpty:
            return (String(localized: "Error"), String(localized: "error_dataEmpty"))
        case .unknownError:
            return (String(localized: "Error"), String(localized: "error_unknownError"))
        case .firestoreError(let firestoreError):
            let errorMessage = String(format: String(localized: "error_firestoreError"), firestoreError.localizedDescription)
            return (String(localized: "Error"), errorMessage)
        case .duplicateRemoved:
            return ("", String(localized: "error_duplicateRemoved"))
        }
        
    }
}
