import Foundation

// MARK: - User location service protocol

/// Интерфейс сервиса по работе с местоположением пользователя.
protocol UserLocationService: AnyObject {
    
    /// Получает статус разрешения на использование местоположения пользователя.
    ///
    /// При необходимости запрашивает данное разрешение.
    /// - Returns: статус разрешения на использования местоположения.
    func getUserLocationPermissionStatus() async -> UserLocationPermissionStatus
    /// Получает текущее местоположение пользователя.
    /// - Returns: местоположение пользователя.
    func getCurrentUserLocation() async throws -> UserLocation
}
