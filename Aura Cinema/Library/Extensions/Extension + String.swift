import Foundation

extension String {
    // MARK: - Форматирования даты с API в дату день/месяц/год -
    func toFormattedDate(inputFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", outputFormat: String = "dd.MM.yyyy") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        return outputFormatter.string(from: date)
    }
}
