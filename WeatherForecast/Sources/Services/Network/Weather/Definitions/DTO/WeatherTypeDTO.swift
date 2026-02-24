import Foundation

// MARK: - Weather type DTO

/// Структура, описывающая `DTO` объект типа погоды.
struct WeatherTypeDTO: Decodable, Sendable {
    
    // MARK: Codings keys
    
    /// Перечень ключей для декодирования структуры из `JSON`-формата.
    ///
    /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
    private enum CodingKeys: String, CodingKey {
        
        // MARK: Cases
        
        case id = "code"
        case name = "text"
        case iconURL = "icon"
    }
    
    // MARK: Properties
    
    let id: Int
    let name: String
    let iconURL: String
}
