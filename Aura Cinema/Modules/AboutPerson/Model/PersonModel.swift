import Foundation

class PersonModel {
    private let movieService = MovieService.shared
    
    func getPesonData(id: Int) async throws -> ([PersonCellItem], [Int]) {
        let data: PersonModelData = try await movieService.fetch(.personCard(id))
        let formattedData = formatData(data)
        var moviesPesonId: [Int] { data.movies?.compactMap { $0.id } ?? [] }
        
        return (formattedData, moviesPesonId)
    }
    
    func getFilmographyData(ids: [Int]) async throws -> [Movie] {
        let result: MovieResponse = try await movieService.fetch(.filmography(ids))
        return result.docs
    }
}

private extension PersonModel {
    func formatData(_ data: PersonModelData) -> [PersonCellItem] {
        var personPhoto: String {
            data.photo ?? ""
        }

        var personName: String {
            let currentLanguage = Locale.current.language.languageCode?.identifier
            let title: String
            if currentLanguage == "ru" {
                title = data.name ?? data.enName ?? String(localized: "unknown")
            } else {
                title = data.enName ?? data.name ?? String(localized: "unknown")
            }
            return title
        }

        var personSex: String {
            let sexValue = data.sex ?? "unknown"
            return String(format: String(localized: "gender"), String(localized: String.LocalizationValue(sexValue)))
        }

        var personGrowth: String {
            guard let growth = data.growth else { return String(localized: "heightUnknown") }
            return String(format: String(localized: "height"), "\(growth)")
        }

        var personBirthday: String {
            guard let birthday = data.birthday?.toFormattedDate() else { return String(localized: "birthdateUnknown") }
            return String(format: String(localized: "birthdate"), birthday)
        }

        var personDeath: String {
            guard let deathDate = data.death?.toFormattedDate() else { return "" }
            return String(format: String(localized: "deathdate"), deathDate)
        }

        var personAge: String {
            guard let age = data.age else { return String(localized: "ageUnknown") }
            return String(localized: "age") + ": \(String(localized: "\(age) years"))"
        }

        var formattedFilmography: [ModelPersonFilmographyCell] {
            data.movies?.map { movie in
                ModelPersonFilmographyCell(
                    id: movie.id ?? 0,
                    description: movie.description ?? ""
                )
            } ?? []
        }
        
        return {[.personPhoto(ModelPersonPhotoCell(photoURL: personPhoto)),
                 .personName(ModelPersonNameCell(name: personName)),
                 .personSex(ModelPersonSexCell(sex: personSex)),
                 .personGrowth(ModelPersonGrowthCell(growth: personGrowth)),
                 .personAge(ModelPersonAgeCell(age: personAge)),
                 .personBirthday(ModelPersonBirthdayCell(birthday: personBirthday)),
                 .personDeath(ModelPersonDeathCell(death: personDeath)),
                 .personFilmography(formattedFilmography)]}()
    }
}
