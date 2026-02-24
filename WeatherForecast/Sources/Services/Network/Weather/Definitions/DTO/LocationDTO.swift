import Foundation

// MARK: - Location DTO

/// Структура, описывающая `DTO` объект локации.
struct LocationDTO: Decodable, Sendable {
    
    // MARK: Codings keys
    
    /// Перечень ключей для декодирования структуры из `JSON`-формата.
    ///
    /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
    private enum CodingKeys: String, CodingKey {
        
        // MARK: Cases
        
        case name
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case timezone = "tz_id"
        case localTime = "localtime"
        case localTimeEpoch = "localtime_epoch"
    }
    
    // MARK: Properties
    
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timezone: String
    let localTime: String
    let localTimeEpoch: Int
}
