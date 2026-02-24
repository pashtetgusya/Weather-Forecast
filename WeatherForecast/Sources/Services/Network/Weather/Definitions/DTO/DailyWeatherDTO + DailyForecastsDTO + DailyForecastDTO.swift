import Foundation

// MARK: - Daily forecast DTO

extension DailyWeatherDTO.DailyForecastsDTO {
    
    /// Структура, описывающая `DTO` объект прогноза погоды за день
    struct DailyForecastDTO: Decodable, Sendable {
        
        // MARK: Codings keys
        
        /// Перечень ключей для декодирования структуры из `JSON`-формата.
        ///
        /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
        private enum CodingKeys: String, CodingKey {
            
            // MARK: Cases
            
            case date
            case dateEpoch = "date_epoch"
            case astroForecast = "astro"
            case averageForecast = "day"
            case hourlyForecasts = "hour"
        }
        
        // MARK: Properties
        
        let date: String
        let dateEpoch: Int
        let astroForecast: AstroForecastDTO
        let averageForecast: AverageForecastDTO
        let hourlyForecasts: [HourlyForecastDTO]
    }
}
