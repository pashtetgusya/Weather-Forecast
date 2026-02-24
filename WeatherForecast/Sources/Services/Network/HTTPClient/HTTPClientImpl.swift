import Foundation

// MARK: - HTTP client implementation

/// Класс, реализующий интерфейс `HTTP`-клиента на основе `URLSession`.
final class HTTPClientImpl {
    
    // MARK: Properties
    
    private let session: URLSession
    private let decoder: HTTPResponseDecoder
    
    // MARK: Initialization
    
    /// Создает новый экземпляр актора.
    /// - Parameters:
    ///   - session: сессия, используемая для выполнения сетевых запросов.
    ///   - decoder: декодер для преобразования данных ответов.
    init(
        session: URLSession = URLSession.shared,
        decoder: HTTPResponseDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
}

// MARK: - HTTP client protocol implementation

extension HTTPClientImpl: HTTPClient {
    
    func execute<T: Decodable & Sendable>(
        with httpRequestEndpoint: HTTPRequestEndpoint
    ) async throws(HTTPRequestError) -> T {
        do {
            let urlRequest = try httpRequestEndpoint.makeURLRueqset()
            let (data, response) = try await session.data(for: urlRequest)
            
            guard
                let response = response as? HTTPURLResponse
            else { throw HTTPRequestError.emptyResponse }
            
            switch response.statusCode {
                case 200...299:
                    do { return try decoder.decode(T.self, from: data) }
                    catch {
                        throw HTTPRequestError.JSON.decode(
                            type: "\(T.self)",
                            description: error.localizedDescription
                        )
                    }
                default: throw HTTPRequestError.invalidStatusCode(response.statusCode)
            }
        }
        catch let error as HTTPRequestError { throw error }
        catch URLError.notConnectedToInternet { throw HTTPRequestError.networkDown }
        catch { throw HTTPRequestError.unknown(error.localizedDescription) }
    }
}
