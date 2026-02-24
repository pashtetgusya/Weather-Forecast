import Foundation

// MARK: - Weather service implementation

/// Класс, реализующий интерфейс сервиса для получения прогноза погоды из сети.
final class WeatherServiceImpl {
    
    // MARK: Properties
    
    /// `HTTP`-клиент для выполнения сетевых запросов.
    private let httpClient: HTTPClient
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    /// - Parameter httpClient: `HTTP`-клиент для выполнения сетевых запросов.
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

// MARK: - Weather service protocol imlementation

extension WeatherServiceImpl: WeatherService {
    
    func getCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async throws(HTTPRequestError) -> CurrentWeatherDTO {
        let endpoint = WeatherHTTPRequestEndpoint.getCurrentWeather(
            latitude: latitude,
            longitude: longitude
        )
        let data: CurrentWeatherDTO = try await httpClient.execute(with: endpoint)
        
        return data
    }
    
    func getWeahterForecast(
        latitude: Double,
        longitude: Double,
        days: Int
    ) async throws (HTTPRequestError) -> DailyWeatherDTO {
        let endpoint = WeatherHTTPRequestEndpoint.getWeahterForecast(
            latitude: latitude,
            longitude: longitude,
            days: days
        )
        let data: DailyWeatherDTO = try await httpClient.execute(with: endpoint)
        
        return data
    }
}
