import Foundation

// MARK: - HTTP client protocol

/// Интерфейс `HTTP`-клиента.
protocol HTTPClient: Sendable {
    
    // MARK: Functions
    
    /// Выполняет `HTTP`-запрос по переданному `endpint'у`.
    /// - Parameters:
    ///   - httpRequestEndpoint: `endpoint` для выполнения запроса.
    ///                          Содержит всю информацию для формирования запроса (`URL`, метод, заголовки и т.д.).
    /// - Returns: Декодированный объект указанного типа `T`.
    /// - Throws: выбрасывает исключение типа `HTTPRequestError`, если процесс выполнения запроса завершился неудачно
    ///           (отсутствие интернет-соединения, сервер вернул ошибку (`4xx` / `5xx`) и т.д.).
    @discardableResult func execute<T: Decodable & Sendable>(
        with httpRequestEndpoint: HTTPRequestEndpoint
    ) async throws(HTTPRequestError) -> T
}
