import Foundation

// MARK: - Daily weather DTO

/// Структура, описывающая `DTO` объект прогноза погоды за несколько дней,
/// включая прогноз погоды на текущий момент времени.
struct DailyWeatherDTO: Decodable, Sendable {
    
    // MARK: Codings keys
    
    /// Перечень ключей для декодирования структуры из `JSON`-формата.
    ///
    /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
    private enum CodingKeys: String, CodingKey {
        
        // MARK: Cases
        
        case location
        case currentWeather = "current"
        case dailyForecasts = "forecast"
    }
    
    // MARK: Properties
    
    let location: LocationDTO
    let currentWeather: CurrentWeatherDTO.ForecastDTO
    let dailyForecasts: DailyForecastsDTO
}
