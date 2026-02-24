import Foundation

// MARK: - Daily weather DTO

extension DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO {
    
    /// Структура, описывающая `DTO` объект среднего прогноза погоды за день.
    struct AverageForecastDTO: Decodable, Sendable {
        
        // MARK: Codings keys
        
        /// Перечень ключей для декодирования структуры из `JSON`-формата.
        ///
        /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
        private enum CodingKeys: String, CodingKey {
            
            // MARK: Cases
            
            case maxTemperatureInCelcius = "maxtemp_c"
            case maxTemperatureInFahrenheit = "maxtemp_f"
            case minTemperatureInCelcius = "mintemp_c"
            case minTemperatureInFahrenheit = "mintemp_f"
            case averageTemperatureInCelcius = "avgtemp_c"
            case averageTemperatureInFahrenheit = "avgtemp_f"
            case maxWindSpeedInKPH = "maxwind_kph"
            case maxWindSpeedInMPH = "maxwind_mph"
            case totalPrecipitationInMM = "totalprecip_mm"
            case totalPrecipitationInIN = "totalprecip_in"
            case totalSnowfallInCM = "totalsnow_cm"
            case averageVisibilityInKM = "avgvis_km"
            case averageVisibilityInMiles = "avgvis_miles"
            case averageHumidity = "avghumidity"
            case dailyWillItRain = "daily_will_it_rain"
            case dailyChanceOfRain = "daily_chance_of_rain"
            case dailyWillItSnow = "daily_will_it_snow"
            case dailyChanceOfSnow = "daily_chance_of_snow"
            case uvIndex = "uv"
            case weatherType = "condition"
        }
        
        // MARK: Properties
        
        let maxTemperatureInCelcius: Double
        let maxTemperatureInFahrenheit: Double
        let minTemperatureInCelcius: Double
        let minTemperatureInFahrenheit: Double
        let averageTemperatureInCelcius: Double
        let averageTemperatureInFahrenheit: Double
        let maxWindSpeedInKPH: Double
        let maxWindSpeedInMPH: Double
        let totalPrecipitationInMM: Double
        let totalPrecipitationInIN: Double
        let totalSnowfallInCM: Double
        let averageVisibilityInKM: Double
        let averageVisibilityInMiles: Double
        let averageHumidity: Int
        let dailyWillItRain: Int
        let dailyChanceOfRain: Int
        let dailyWillItSnow: Int
        let dailyChanceOfSnow: Int
        let uvIndex: Double
        let weatherType: WeatherTypeDTO
    }
}
