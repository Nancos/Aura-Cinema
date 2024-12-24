// MARK: - PersonModelData
struct PersonModelData: Codable {
    let id: Int
    let name: String?
    let enName: String? //en_name
    let photo: String?
    let sex: String?
    let growth: Int?
    let birthday: String?
    let death: String?
    let age: Int?
    let movies: [Filmography]?
}

// MARK: - Filmography
struct Filmography: Codable {
    let id: Int?
    let name: String?
    let rating: Double?
    let description: String?
}

enum PersonCellItem {
    case personPhoto(ModelPersonPhotoCell)
    case personName(ModelPersonNameCell)
    case personSex(ModelPersonSexCell)
    case personGrowth(ModelPersonGrowthCell)
    case personAge(ModelPersonAgeCell)
    case personBirthday(ModelPersonBirthdayCell)
    case personDeath(ModelPersonDeathCell)
    case personFilmography([ModelPersonFilmographyCell])
}

// MARK: - Модели данных для каждой ячейки

struct ModelPersonPhotoCell {
    let photoURL: String
}

struct ModelPersonNameCell {
    let name: String
}

struct ModelPersonSexCell {
    let sex: String
}

struct ModelPersonGrowthCell {
    let growth: String
}

struct ModelPersonAgeCell {
    let age: String
}

struct ModelPersonBirthdayCell {
    let birthday: String
}

struct ModelPersonDeathCell {
    let death: String
}

struct ModelPersonFilmographyCell {
    let id: Int
    let description: String
}
