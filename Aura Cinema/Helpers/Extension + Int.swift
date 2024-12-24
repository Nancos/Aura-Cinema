//
//  Extension + Int.swift
//  Aura Cinema
//
//  Created by MacBook Air on 19.01.25.
//

extension Int {
    // MARK: - Выбор окончания к году/годам/лет -
    func yearsString() -> String {
        let lastTwoDigits = self % 100
        let lastDigit = self % 10

        if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
            return "\(self) лет"
        } else if lastDigit == 1 {
            return "\(self) год"
        } else if lastDigit >= 2 && lastDigit <= 4 {
            return "\(self) года"
        } else {
            return "\(self) лет"
        }
    }
}
