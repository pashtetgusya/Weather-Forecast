import Foundation
import CoreLocation
import MapKit

// MARK: - User location service implementation

/// Класс, реализующий интерфейс сервиса по работе с местоположением пользователя
/// на основе `CLLocationManager`.
final class UserLocationServiceImpl: NSObject {
    
    // MARK: Properties
    
    private let clManager: CLLocationManager
    private var permissionAuthorizationContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
    private var userLocationContinuation: CheckedContinuation<UserLocation, Error>?
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    override init() {
        self.clManager = CLLocationManager()
        
        super.init()
        
        self.clManager.delegate = self
    }
}

// MARK: - User location service protocol implementation

extension UserLocationServiceImpl: UserLocationService {
    
    func getUserLocationPermissionStatus() async -> UserLocationPermissionStatus {
        let currentStatus = clManager.authorizationStatus
        let newStatus = switch currentStatus {
            case .notDetermined:
                await withCheckedContinuation { continuation in
                    permissionAuthorizationContinuation = continuation
                    clManager.requestAlwaysAuthorization()
                }
            default: currentStatus
        }
        
        switch newStatus {
            case .authorizedAlways, .authorizedWhenInUse: return .authorized
            default: return .notAuthorized
        }
    }
    
    func getCurrentUserLocation() async throws -> UserLocation {
        try await withCheckedThrowingContinuation { continuation in
            self.userLocationContinuation = continuation
            self.clManager.requestLocation()
        }
    }
}

// MARK: - CL location manager delegate protocol implementation

extension UserLocationServiceImpl: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        permissionAuthorizationContinuation?.resume(returning: manager.authorizationStatus)
        permissionAuthorizationContinuation = nil
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        
        let coordinate = UserLocation.Coordinate(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        let userLocation = UserLocation(name: "", coordinate: coordinate)
        userLocationContinuation?.resume(returning: userLocation)
        userLocationContinuation = nil
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        userLocationContinuation?.resume(throwing: error)
        userLocationContinuation = nil
    }
}
