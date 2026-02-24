import Foundation

// MARK: - HTTP request endpoint protocol

/// Интерфейс `endpoint'а` для выполнения `HTTP`-запроса.
protocol HTTPRequestEndpoint: Sendable {
    
    // MARK: Properties
    
    /// `HTTP`-метод запроса.
    var method: HTTPRequestMethod { get }
    /// Протокол соединения.
    /// Определяет схему `URL` (`http` / `https`).
    var scheme: HTTPRequestScheme { get }
    /// Доменное имя или `IP`-адрес сервера, к которому направляется запрос.
    /// - Пример: `"api.example.com"` / `"192.0.0.1"`.
    var host: String { get }
    /// Путь относительно хоста, определяющий ресурс или действие (должен начинаться с `/`).
    /// - Пример: `"/users/profile"`.
    var path: String { get }
    /// Дополнительные `HTTP`-заголовки запроса.
    var headers: [String: String]? { get }
    /// Параметры `URL`-запроса
    var queryItems: [String: String]? { get }
    /// Текстовое описание `endpoint'а` для логирования и отладки.
    var debugDescription: String { get }
    
    // MARK: Functions
    
    /// Создает `URLRequest` на основе параметров `endpoint'а`.
    /// - Returns: Созданный `URLRequest`.
    /// - Throws: выбрасывает исключение типа `HTTPRequestError`, если процесс создания `URLRequest` завершился неудачно
    ///           (невалидный `URL` и т. д.).
    func makeURLRueqset() throws (HTTPRequestError) -> URLRequest
}

// MARK: - HTTP request endpoint protocol base implementation

extension HTTPRequestEndpoint {
    
    // MARK: Properties
    
    var debugDescription: String {
        var description = "\(method.rawValue) \(scheme)://\(host)\(path)"
        
        if let queryItems {
            let queryDescription = queryItems
                .map { "\($0.key)=\($0.value)" }
                .joined(separator: "&")
            
            description += "?\(queryDescription)"
        }
        
        if let headers {
            let headersDescription = headers
                .map { "   \($0.key): \($0.value)" }
                .joined(separator: "\n")
            
            description += "\nHeaders:\n \(headersDescription)"
        }
        
        return description
    }
    
    // MARK: Functions
    
    func makeURLRueqset() throws (HTTPRequestError) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme.rawValue
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems?.compactMap { .init(name: $0.key, value: $0.value) }
        
        guard
            let url = urlComponents.url
        else { throw .invalidURL(debugDescription) }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 5
        
        return urlRequest
    }
}
