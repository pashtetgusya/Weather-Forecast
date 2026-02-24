import Foundation
import Combine

// MARK: - Weather view model

/// Вью модель для вью контроллера экрана прогноза погоды.
final class WeatherViewModel {
    
    /// Перечень статусов состояния вью модели.
    enum State {
        
        // MARK: Cases
        
        case idle
        case loading
        case loaded(weahterSections: [WeatherCollectionViewModel.Section])
        case errorLoading
    }
    
    // MARK: Properties
    
    private let locationService: UserLocationService
    private let weatherService: WeatherService
    private var userLocation: UserLocation?
    
    @Published var state: State
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init(
        locationService: UserLocationService,
        weatherService: WeatherService
    ) {
        self.locationService = locationService
        self.weatherService = weatherService
        
        self.state = .idle
    }
}

// MARK: - Load functions

extension WeatherViewModel {
    
    /// Выполняет загрузку прогноза погоды.
    func loadWeather() {
        Task { [weak self] in
            guard let self else { return }
            
            do {
                state = .loading
                let userLocation = await getUserLocation()
                let weatherSections = try await getWeather(for: userLocation)
                state = .loaded(weahterSections: weatherSections)
            }
            catch {
                state = .errorLoading
            }
        }
    }
    
    /// Выполняет получение лекущей локации пользователя.
    /// - Returns: локация пользователя.
    private func getUserLocation() async -> UserLocation {
        do {
            let permissionStatus = await locationService.getUserLocationPermissionStatus()
            let userLocation = switch permissionStatus {
                case .authorized: try await locationService.getCurrentUserLocation()
                case .notAuthorized: UserLocation.default
            }
            
            return userLocation
        }
        catch {
            return UserLocation.default
        }
    }
    
    /// Выполняет получение погоды по переданной локации.
    /// - Parameter userLocation: локация для которой загружается погода.
    /// - Returns: секции с информацией о погоде для отображения.
    private func getWeather(for userLocation: UserLocation) async throws -> [WeatherCollectionViewModel.Section] {
        let currentWeatherDTO = try await weatherService.getCurrentWeather(
            latitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude
        )
        let weatherForecastDTO = try await weatherService.getWeahterForecast(
            latitude: userLocation.coordinate.latitude,
            longitude: userLocation.coordinate.longitude,
            days: 3
        )
        let weatherSections = [
            getCurrentWeahterSection(
                currentWeatherDTO: currentWeatherDTO,
                dailyForecastDTO: weatherForecastDTO.dailyForecasts.dailyForecastsDTO[safe: 0]
            ),
            getHourlyWeatherSection(weatherForecastDTO: weatherForecastDTO),
            getDailyWeatherSection(weatherForecastDTO: weatherForecastDTO)
        ].sorted { $0.kind.index < $1.kind.index }
        
        return weatherSections
    }
}

// MARK: - Support functions

private extension WeatherViewModel {
    
    /// Создает секцию с информацией отекущем прогнозе погоды.
    /// - Parameters:
    ///   - currentWeatherDTO: `DTO` объект с информацией о текущей погоде.
    ///   - dailyForecastDTO: `DTO` объект с информацией о прогнозе погоды на текущий день.
    /// - Returns: секция с информацией отекущем прогнозе погоды.
    func getCurrentWeahterSection(
        currentWeatherDTO: CurrentWeatherDTO,
        dailyForecastDTO: DailyWeatherDTO.DailyForecastsDTO.DailyForecastDTO?
    ) -> WeatherCollectionViewModel.Section {
        let currentWeahterSection = WeatherCollectionViewModel.Section(
            kind: .currentWeather,
            rows: [.currentWeather(model: WeatherModel.CurrentWeather(
                currentWeatherDTO: currentWeatherDTO,
                averageForecastDTO: dailyForecastDTO?.averageForecast
            ))]
        )
        
        return currentWeahterSection
    }
    
    /// Создает секцию с информацией о почасовом прогнозе погоды на ближайшие 24 часа.
    /// - Parameter weatherForecastDTO: `DTO` объект с информацией о прогнозе погоды на ближайщие 2 дня.
    /// - Returns: секция с информацией о прогнозе погоды на ближайшие 24 часа.
    func getHourlyWeatherSection(
        weatherForecastDTO: DailyWeatherDTO
    ) -> WeatherCollectionViewModel.Section {
        let currentDateTimeInterval = Int(Date.now.timeIntervalSince1970)
        let hourlyWeatherTodayModels = weatherForecastDTO.dailyForecasts.dailyForecastsDTO[safe: 0]?
            .hourlyForecasts
            .filter { $0.timeEpoch > currentDateTimeInterval }
            .map { WeatherModel.HourlyWeather(hourlyWeaherDTO: $0) } ?? []
        let hourlyWeatherTomorrowModels = weatherForecastDTO.dailyForecasts.dailyForecastsDTO[safe: 1]?
            .hourlyForecasts
            .map { WeatherModel.HourlyWeather(hourlyWeaherDTO: $0) } ?? []
        
        let hourlyWeatherModels = hourlyWeatherTodayModels + hourlyWeatherTomorrowModels
        let hourlyWeatherSection = WeatherCollectionViewModel.Section(
            kind: .hourlyWeather,
            rows: hourlyWeatherModels.map { .hourlyWeather(model: $0) }
        )
        
        return hourlyWeatherSection
    }
    
    /// Создает секцию с информацией о прознозе погоды на несколько дней.
    /// - Parameter weatherForecastDTO: `DTO` объект с информацией о прогнозе погоды на несколько дней.
    /// - Returns: секция с информацией о прогнозе погоды на несколько дней.
    func getDailyWeatherSection(
        weatherForecastDTO: DailyWeatherDTO
    ) -> WeatherCollectionViewModel.Section {
        let dailyWeatherModels = weatherForecastDTO.dailyForecasts.dailyForecastsDTO
            .map { WeatherModel.DailyWeahter(dailyForecastDTO: $0) }
        let dailyWeatherSection = WeatherCollectionViewModel.Section(
            kind: .dailyWeather,
            rows: dailyWeatherModels.map { .dailyWeather(model: $0) }
        )
        
        return dailyWeatherSection
    }
}
