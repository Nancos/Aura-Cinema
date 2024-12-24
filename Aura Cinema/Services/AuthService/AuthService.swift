//
//  Auth.swift
//  Aura Cinema
//
//  Created by MacBook Air on 15.01.25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    func createNewUser(user: UserData, completion: @escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let self = self else { return }
            
            guard error == nil else {
                completion(.failure(SignInError.unknowError))
                return
            }
            result?.user.sendEmailVerification()
            
            guard let uid = result?.user.uid else { return }
            
            setUserData(user: user, userID: uid, completion: {_ in })
            
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
    
    func signIn(user: UserData, completion: @escaping (Result<Bool,Error>) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] result, error in
            
            guard let `self` = self else { return }
            
            guard error == nil else {
                completion(.failure(SignInError.unknowError))
                return
            }
            
            guard let user = result?.user else {
                completion(.failure(SignInError.invalidUser))
                return
            }
            
            if !user.isEmailVerified {
                completion(.failure(SignInError.notVerification))
                result?.user.sendEmailVerification()
                signOut()
                return
            }
            
            completion(.success(true))
        }
    }
    
    func isLogin() async -> Bool {
        if (Auth.auth().currentUser != nil) {
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
}

extension AuthService {
    func switchErrorToAlert(_ error: Error) -> String {
        switch error as? SignInError {
        case .invalidUser:
            return "Данного пользователя не существует"
        case .notVerification:
            return "Необходимо подтвердить email"
        case .unknowError:
            return "Что-то пошло не так, попробуйте еще раз..."
        case .none:
            return "Неизвестная ошибка. Обратитесь в поддержку."
        }
    }
}
