import Foundation

// MARK: - Weather model

/// Модель экрана прогноза погоды.
enum WeatherModel {
    
    // MARK: Current weather model
    
    /// Структура, описывающая прогноз погоды на текущий момент времени.
    struct CurrentWeather: Hashable {
        
        // MARK: Properties
        
        let locationName: String
        let weatherType: String
        let currentTemperature: Double
        let maxTemperature: Double
        let minTemperature: Double
        
        // MARK: Initialization
        
        /// Создает новый экземпляр структуры.
        init(
            currentWeatherDTO: CurrentWeatherDTO,
            averageForecastDTO: DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO.AverageForecastDTO?
        ) {
            self.locationName = currentWeatherDTO.location.name
            self.weatherType = currentWeatherDTO.forecast.weatherType.name
            self.currentTemperature = currentWeatherDTO.forecast.temperatureInCelsius
            self.maxTemperature = averageForecastDTO?.maxTemperatureInCelcius ?? 0
            self.minTemperature = averageForecastDTO?.minTemperatureInCelcius ?? 0
        }
    }
    
    // MARK: Hourly weather model
    
    /// Структура, описывающая прогноз погоды за час.
    struct HourlyWeather: Hashable {
        
        // MARK: Properties
        
        let time: String
        let temperature: Double
        let iconURL: URL?
        
        // MARK: Initialization
        
        /// Создает новый экземпляр структуры.
        init(hourlyWeaherDTO: DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO.HourlyForecastDTO) {
            let date = (try? Date(hourlyWeaherDTO.time, strategy: .dateTime)) ?? Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            
            self.time = dateFormatter.string(from: date)
            self.temperature = hourlyWeaherDTO.temperatureInCelsius
            self.iconURL = URL(string: "https://" + String(hourlyWeaherDTO.weatherType.iconURL.dropFirst(2)))
        }
    }
    
    // MARK: Daily weather
    
    /// Структура, описывающая прогноз погоды за день.
    struct DailyWeahter: Hashable {
        
        // MARK: Properties
        
        let date: String
        let minTemperature: Double
        let maxTemperature: Double
        let iconURL: URL?
        
        // MARK: Initialization
        
        /// Создает новый экземпляр структуры.
        init(dailyForecastDTO: DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO) {
            let timeInterval = TimeInterval(dailyForecastDTO.dateEpoch)
            let date = Date(timeIntervalSince1970: timeInterval)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            
            self.date = Calendar.current.isDateInToday(date)
                        ? "Today"
                        : dateFormatter.string(from: date)
            self.minTemperature = dailyForecastDTO.averageForecast.minTemperatureInCelcius
            self.maxTemperature = dailyForecastDTO.averageForecast.maxTemperatureInCelcius
            self.iconURL = URL(string: "https://" + String(dailyForecastDTO.averageForecast.weatherType.iconURL.dropFirst(2)))
        }
    }
}
