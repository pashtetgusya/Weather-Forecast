import Foundation

// MARK: - Weather service constants

/// Константы, используемые при работе с `API` для получения прогнозов погоды.
enum WeatherServiceConstants {
    
    // MARK: Properties
    
    /// Доменное имя для выполнения запросов к `API`.
    static let host: String = "api.weatherapi.com"
    /// Ключ для выполнения запросов к `API`.
    static let key: String = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String ?? ""
}
