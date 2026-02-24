import Foundation

// MARK: - HTTP response decoder protocol

/// Протокол, определяющий интерфейс для преобразования данных `HTTP`-ответов в `Decodable`-типы.
protocol HTTPResponseDecoder: Sendable {
    
    /// Выполняет преобразование данных в переданный `Decodable`-тип.
    /// - Parameters:
    ///   - type: тип, в который нужно преобразовать данные.
    ///   - data: данные для преобразования.
    /// - Returns: готовый объект указанного типа.
    /// - Throws: выбрасывает исключение, если процесс преобразования завершился неудачно.
    func decode<T: Decodable & Sendable>(_ type: T.Type, from data: Data) throws -> T
}
