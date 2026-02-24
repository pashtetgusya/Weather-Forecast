import Foundation

// MARK: - Weather service

/// Интерфейс сервиса для получения прогноза погоды из сети.
protocol WeatherService: Sendable {
    
    /// Выполняет запрос на получение прогноза погоды на текущий момент времени по переданному местоположению.
    /// - Parameters:
    ///   - latitude: широта.
    ///   - longitude: долгота.
    /// - Returns: прогноз погоды на текущий момент времени.
    func getCurrentWeather(latitude: Double, longitude: Double) async throws(HTTPRequestError) -> CurrentWeatherDTO
    /// Выполняет запрос на получение прогноза погоды за несколько дней по переданному местоположению.
    /// - Parameters:
    ///   - latitude: широта.
    ///   - longitude: долгота.
    ///   - days: количество дней на которое необходимо получить прогноз погоды включая текущий.
    /// - Returns: прогноз погоды за несколько дней.
    func getWeahterForecast(latitude: Double, longitude: Double, days: Int) async throws(HTTPRequestError) -> DailyWeatherDTO
}
