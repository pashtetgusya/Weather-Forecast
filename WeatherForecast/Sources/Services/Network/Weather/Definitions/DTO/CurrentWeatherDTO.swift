import Foundation

// MARK: - Current weather DTO

/// Структура, описывающая `DTO` объект прогноза погоды на текущий момент времени.
struct CurrentWeatherDTO: Decodable, Sendable {
    
    // MARK: Codings keys
    
    /// Перечень ключей для декодирования структуры из `JSON`-формата.
    ///
    /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
    private enum CodingKeys: String, CodingKey {
        
        // MARK: Cases
        
        case location
        case forecast = "current"
        
    }
    
    // MARK: Properties
    
    let location: LocationDTO
    let forecast: ForecastDTO
}
