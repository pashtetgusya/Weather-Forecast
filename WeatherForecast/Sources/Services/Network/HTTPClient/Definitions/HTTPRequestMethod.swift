import Foundation

// MARK: - HTTP request method

/// Перечень методов `HTTP`-запросов.
enum HTTPRequestMethod: String {
    
    // MARK: Cases
    
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
