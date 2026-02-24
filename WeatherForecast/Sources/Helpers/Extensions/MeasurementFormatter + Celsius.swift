import Foundation

// MARK: - Celsius measurment formatter

extension MeasurementFormatter {
    
    /// Форматтер для температуры в градусах цельсия.
    static let celsius: MeasurementFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.roundingMode = .halfUp
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter = numberFormatter
        
        return measurementFormatter
    }()
}
