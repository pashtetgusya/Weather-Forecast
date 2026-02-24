import Foundation

// MARK: - Astro forecast DTO

extension DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO {
    
    /// Структура, описывающая `DTO` объект астрологического прогноза погоды за день.
    struct AstroForecastDTO: Decodable, Sendable {
        
        // MARK: Codings keys
        
        /// Перечень ключей для декодирования структуры из `JSON`-формата.
        ///
        /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
        private enum CodingKeys: String, CodingKey {
            
            // MARK: Cases
            
            case sunRise = "sunrise"
            case sunSet = "sunset"
            case moonRise = "moonrise"
            case moonSet = "moonset"
            case moonPhase = "moon_phase"
            case moonIllumination = "moon_illumination"
            case isMoonUp = "is_moon_up"
            case isSunUp = "is_sun_up"
        }
        
        // MARK: Properties
        
        let sunRise: String
        let sunSet: String
        let moonRise: String
        let moonSet: String
        let moonPhase: String
        let moonIllumination: Double
        let isMoonUp: Int
        let isSunUp: Int
    }
}
