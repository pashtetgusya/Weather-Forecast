import UIKit

// MARK: - Application dependency container

/// Класс, отвечающий за сборку и хранение зависимостей приложения.
final class AppDIContainer {
    
    // MARK: Properties
    
    let weatherService: WeatherService
    let locationService: UserLocationService
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init() {
        let httpClient = HTTPClientImpl()
        let weatherService = WeatherServiceImpl(httpClient: httpClient)
        let locationService = UserLocationServiceImpl()
        
        self.weatherService = weatherService
        self.locationService = locationService
    }
}
