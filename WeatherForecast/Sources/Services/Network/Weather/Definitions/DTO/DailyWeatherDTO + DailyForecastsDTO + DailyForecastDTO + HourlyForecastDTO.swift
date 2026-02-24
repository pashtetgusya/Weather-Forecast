import Foundation

// MARK: - Hourly forecast DTO

extension DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO {
    
    /// Структура, описывающая `DTO` объект  прогноза погоды за час.
    struct HourlyForecastDTO: Decodable, Sendable {
        
        // MARK: Codings keys
        
        /// Перечень ключей для декодирования структуры из `JSON`-формата.
        ///
        /// Обеспечивает маппинг между именами полей `JSON`-представления и свойствами структуры.
        private enum CodingKeys: String, CodingKey {
            
            // MARK: Cases
            
            case time
            case timeEpoch = "time_epoch"
            case temperatureInCelsius = "temp_c"
            case temperatureInFahrenheit = "temp_f"
            case feelslikeTemperatureInCelsius = "feelslike_c"
            case feelslikeTemperatureInFahrenheit = "feelslike_f"
            case windchillTemperatureInCelsius = "windchill_c"
            case windchillTemperatureInFahrenheit = "windchill_f"
            case dewPointInCelsius = "dewpoint_c"
            case dewPointInFahrenheit = "dewpoint_f"
            case heatIndexInCelsius = "heatindex_c"
            case heatIndexInFahrenheit = "heatindex_f"
            case windGustInKPH = "gust_mph"
            case windGustInMPH = "gust_kph"
            case windSpeedInKPH = "wind_kph"
            case windSpeedInMPH = "wind_mph"
            case windDirection = "wind_dir"
            case windDirectionInDegrees = "wind_degree"
            case visibilityInKM = "vis_km"
            case visibilityInMiles = "vis_miles"
            case uvIndex = "uv"
            case pressureInMB = "pressure_mb"
            case pressureInIN = "pressure_in"
            case precipitationAmountInMM = "precip_mm"
            case precipitationAmountInIN = "precip_in"
            case humidity
            case cloudCover = "cloud"
            case hourlyWillItRain = "will_it_rain"
            case hourlyChanceOfRain = "chance_of_rain"
            case hourlyWillItSnow = "will_it_snow"
            case hourlyChanceOfSnow = "chance_of_snow"
            case weatherType = "condition"
            case isNeedShowDayIcon = "is_day"
        }
        
        // MARK: Properties
        
        let time: String
        let timeEpoch: Int
        let temperatureInCelsius: Double
        let temperatureInFahrenheit: Double
        let feelslikeTemperatureInCelsius: Double
        let feelslikeTemperatureInFahrenheit: Double
        let windchillTemperatureInCelsius: Double
        let windchillTemperatureInFahrenheit: Double
        let dewPointInCelsius: Double
        let dewPointInFahrenheit: Double
        let heatIndexInCelsius: Double
        let heatIndexInFahrenheit: Double
        let windGustInKPH: Double
        let windGustInMPH: Double
        let windSpeedInKPH: Double
        let windSpeedInMPH: Double
        let windDirection: String
        let windDirectionInDegrees: Int
        let visibilityInKM: Double
        let visibilityInMiles: Double
        let uvIndex: Double
        let pressureInMB: Double
        let pressureInIN: Double
        let precipitationAmountInMM: Double
        let precipitationAmountInIN: Double
        let humidity: Int
        let cloudCover: Int
        let hourlyWillItRain: Int
        let hourlyChanceOfRain: Int
        let hourlyWillItSnow: Int
        let hourlyChanceOfSnow: Int
        let weatherType: WeatherTypeDTO
        let isNeedShowDayIcon: Int
    }
}
