import Foundation

// MARK: - HTTP request JSON error

extension HTTPRequestError {
    
    /// Энам, описывающий перечень возможных ошибок при работе с `JSON` форматом.
    enum JSON: LocalizedError {
        
        // MARK: Cases
        
        case encode(type: String, description: String)
        case decode(type: String, description: String)
        
        // MARK: Properties
        
        var errorDescription: String? {
            switch self {
                case .encode(let type, let description):
                    "Не удалось преобразовать переданную модель \(type) в `JSON` формат. \(description)"
                case .decode(let type, let description):
                    "Не удалось преобразовать данные из `JSON` формата в указанную модель \(type). \(description)"
            }
        }
        
        var failureReason: String? {
            "Пожалуйста проверьте валидность переданной модели данных."
        }
    }
}
