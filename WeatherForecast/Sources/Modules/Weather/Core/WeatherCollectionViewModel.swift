import Foundation

// MARK: - Weather collection view model

/// Описание модели данных коллекции отображения прогноза погоды.
enum WeatherCollectionViewModel {
    
    // MARK: Section
    
    /// Структура, описывающия секцию прогноза погоды.
    struct Section {
        
        // MARK: Section type
        
        /// Перечень возможных типов секций прогноза погоды.
        enum Kind: Hashable {
            
            // MARK: Cases
            
            case currentWeather
            case hourlyWeather
            case dailyWeather
            
            // MARK: Properties
            
            var index: Int {
                switch self {
                    case .currentWeather: 0
                    case .hourlyWeather: 1
                    case .dailyWeather: 2
                }
            }
        }
        
        // MARK: Section row
        
        /// Ячейка секции прогноза погоды.
        enum Row: Hashable {
            
            // MARK: Cases
            
            case currentWeather(model: WeatherModel.CurrentWeather)
            case hourlyWeather(model: WeatherModel.HourlyWeather)
            case dailyWeather(model: WeatherModel.DailyWeahter)
        }
        
        // MARK: Properties
        
        let kind: Section.Kind
        let rows: [Section.Row]
    }
}
