import Foundation

// MARK: - HTTP request error

/// Энам, описывающий перечень возможных ошибок при выполнении `HTTP`-запросов.
enum HTTPRequestError: LocalizedError {
    
    // MARK: Cases
    
    case networkDown
    case invalidURL(_ urlString: String)
    case emptyResponse
    case invalidStatusCode(_ statusCode: Int)
    case unknown(_ description: String)
    
    // MARK: Properties
    
    var errorDescription: String? {
        switch self {
            case .networkDown:
                "Отсутствует интернет-соединение."
            case .invalidURL(let urlString):
                "Невозможно создать валидный `URL` из переданной строки: \(urlString)."
            case .emptyResponse:
                "Сервер вернул пустой ответ."
            case .invalidStatusCode(let statusCode):
                "Сервер вернул невалидный статус-код: \(statusCode)."
            case .unknown(let description):
                "Произошла неизвестная ошибка. \(description)"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
            case .networkDown: "Проверьте подключение к сети."
            case .invalidURL: "Проверьте валидность переданной `URL` строки."
            case .emptyResponse,
                 .invalidStatusCode,
                 .unknown: "Пожалуйста попробуйте позже."
        }
    }
}
