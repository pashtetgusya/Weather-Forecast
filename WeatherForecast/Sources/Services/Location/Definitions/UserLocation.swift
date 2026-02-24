import Foundation

// MARK: - Location

/// Структура, описывающая локацию пользователя.
struct UserLocation: Sendable, Encodable {
    
    /// Локация пользователя по умолчанию.
    static let `default` = UserLocation(
        name: "Москва",
        coordinate: Coordinate(latitude: 55.7522, longitude: 37.6156)
    )
    
    // MARK: Properties
    
    /// Название локации.
    let name: String
    /// Координаты локации.
    let coordinate: Coordinate
}
