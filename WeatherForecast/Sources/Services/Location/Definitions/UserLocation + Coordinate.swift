import Foundation

// MARK: - User location coordinate

extension UserLocation {
    
    /// Структура, описывающая координаты локации пользователя.
    struct Coordinate: Sendable, Encodable {
        
        // MARK: Properties
        
        /// Широта.
        let latitude: Double
        /// Долгота.
        let longitude: Double
    }
}
