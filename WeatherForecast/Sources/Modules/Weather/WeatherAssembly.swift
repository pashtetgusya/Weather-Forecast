import UIKit

// MARK: - Weather dependency injection assembly

/// Класс, отвечающий за сборку экрана погоды.
final class WeatherAssembly {
    
    // MARK: Initialization
    
    private init() { }
    
    // MARK: Build function
    
    /// Выполняет сборку экрана погоды.
    /// - Returns: экран погоды.
    static func build(
        locationService: UserLocationService,
        weatherService: WeatherService
    ) -> UIViewController {
        let viewModel = WeatherViewModel(
            locationService: locationService,
            weatherService: weatherService
        )
        let viewController = WeatherViewController(viewModel: viewModel)
        
        return viewController
    }
}
