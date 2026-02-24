import Foundation

// MARK: - Weather HTTP request endpoint

/// Перечень `endpoint'ов` для `HTTP`-запросов к `API` получения прогнозов погоды.
enum WeatherHTTPRequestEndpoint: HTTPRequestEndpoint {
    
    // MARK: Cases
    
    /// `Endpoint` для получения прогноза погоды на текущий момент времени по переданному местоположению.
    /// - Parameter latitude: широта.
    /// - Parameter longitude: долгота.
    /// - Returns: `endpoint` для запроса.
    case getCurrentWeather(latitude: Double, longitude: Double)
    /// `Endpoint` для получения прогноза погоды на текущий момент времени по переданному местоположению.
    /// - Parameter latitude: широта.
    /// - Parameter longitude: долгота.
    /// - Parameter days: количество дней на которое необходимо получить прогноз погоды включая текущий.
    /// - Returns: `endpoint` для запроса.
    case getWeahterForecast(latitude: Double, longitude: Double, days: Int)
    
    // MARK: Properties
    
    var method: HTTPRequestMethod { .get }
    var scheme: HTTPRequestScheme { .https }
    var host: String { WeatherServiceConstants.host }
    var path: String {
        switch self {
            case .getCurrentWeather: "/v1/current.json"
            case .getWeahterForecast: "/v1/forecast.json"
        }
    }
    var headers: [String: String]? { nil }
    var queryItems: [String: String]? {
        switch self {
            case .getCurrentWeather(let latitude, let longitude):
                ["key": WeatherServiceConstants.key,
                 "q": "\(latitude),\(longitude)"]
            case .getWeahterForecast(let latitude, let longitude, let days):
                ["key": WeatherServiceConstants.key,
                 "q": "\(latitude),\(longitude)",
                 "days": "\(days)"]
        }
    }
}
