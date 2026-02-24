import Foundation

// MARK: - Daily weathers DTO

extension DailyWeatherDTO {
    
    /// Структура, описывающая `DTO` объект списка прогнозов погоды за несколько дней.
    struct DailyForecastsDTO: Decodable, Sendable {
        
        // MARK: Codings keys
        
        /// Перечень ключей для декодирования структуры из `JSON`-формата.
        ///
        /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
        private enum CodingKeys: String, CodingKey {
            
            // MARK: Cases
            
            case dailyForecastsDTO = "forecastday"
        }
        
        // MARK: Properties
        
        let dailyForecastsDTO: [DailyForecastDTO]
    }
}
