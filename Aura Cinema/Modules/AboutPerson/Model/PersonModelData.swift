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



// MARK: - PersonViewModel -
struct PersonViewModel {
    private let personData: PersonModelData
    
    init(personData: PersonModelData) {
        self.personData = personData
    }
    
    var items: [PersonCellItem] {
      [.personPhoto(ModelPersonPhotoCell(photoURL: personPhoto)),
       .personName(ModelPersonNameCell(name: personName)),
       .personSex(ModelPersonSexCell(sex: personSex)),
       .personGrowth(ModelPersonGrowthCell(growth: personGrowth)),
       .personAge(ModelPersonAgeCell(age: personAge)),
       .personBirthday(ModelPersonBirthdayCell(birthday: personBirthday)),
       .personDeath(ModelPersonDeathCell(death: personDeath)),
       .personFilmography(formattedFilmography)]
    }
}

// MARK: - Private methods -
private extension PersonViewModel {
   
    var personPhoto: String { personData.photo ?? "" }
    var personName: String { personData.name ?? personData.enName ?? "неизвестно" }
    var personSex: String { "Пол: " + (personData.sex ?? "неизвестно").lowercased() }
    var personGrowth: String { personData.growth.map { "Рост: \($0) см" } ?? "Рост: неизвестно" }
    var personBirthday: String { personData.birthday?.toFormattedDate().map { "Дата рождения: \($0) г." } ?? "Дата рождения: неизвестно" }
    var personDeath: String { personData.death?.toFormattedDate().map { "Дата смерти: \($0) г." } ?? "" }
    var personAge: String { personData.age.map { "Возраст: \($0.yearsString())" } ?? "Возраст: неизвестно" }
    var formattedFilmography: [ModelPersonFilmographyCell] {
        personData.movies?.map { movie in
            ModelPersonFilmographyCell(id: movie.id ?? 0,
                                       description: movie.description ?? "")} ?? []
    }
}
