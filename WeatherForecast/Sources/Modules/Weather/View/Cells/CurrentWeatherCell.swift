import UIKit

// MARK: - Current weather cell

/// Ячейка отображения текущего прогноза погоды.
final class CurrentWeatherCell: UICollectionViewCell {
    
    // MARK: Subviews
    
    private let locationNameLabel = UILabel()
    private let currentTempLabel = UILabel()
    private let cuttenrWeatherTypeLabel = UILabel()
    private let dailyTempLabel = UILabel()
    
    // MARK: Properties
    
    private let measurementFormatter = MeasurementFormatter.celsius
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupAppearance()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
}

// MARK: - Configuration function

extension CurrentWeatherCell {
    
    /// Выполнят настройку ячейке на основе переданной моделе.
    /// - Parameter model: модель для настройки ячейки.
    func setup(with model: WeatherModel.CurrentWeather) {
        let currentTempMeasurement = Measurement(value: model.currentTemperature, unit: UnitTemperature.celsius)
        let minTempMeasurement = Measurement(value: model.minTemperature, unit: UnitTemperature.celsius)
        let maxTempMeasurement = Measurement(value: model.maxTemperature, unit: UnitTemperature.celsius)
        let minTempText = measurementFormatter.string(from: minTempMeasurement)
        let maxTempText = measurementFormatter.string(from: maxTempMeasurement)
        
        currentTempLabel.text = measurementFormatter.string(from: currentTempMeasurement)
        locationNameLabel.text = model.locationName
        cuttenrWeatherTypeLabel.text = model.weatherType
        dailyTempLabel.text = "min: \(minTempText), max: \(maxTempText)"
    }
}

// MARK: - Setup functions

private extension CurrentWeatherCell {
    
    /// Выполняет добавление `view`-компонентов.
    func addSubviews() {
        contentView.addSubview(locationNameLabel)
        contentView.addSubview(currentTempLabel)
        contentView.addSubview(cuttenrWeatherTypeLabel)
        contentView.addSubview(dailyTempLabel)
    }
    
    /// Выполняет настройку `view`-компонентов.
    func setupAppearance() {
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 25
        
        locationNameLabel.textColor = .label
        locationNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        locationNameLabel.textAlignment = .center
        
        currentTempLabel.textColor = .label
        currentTempLabel.font = .systemFont(ofSize: 36, weight: .bold)
        currentTempLabel.textAlignment = .center
        
        cuttenrWeatherTypeLabel.textColor = .label
        cuttenrWeatherTypeLabel.font = .systemFont(ofSize: 18, weight: .bold)
        cuttenrWeatherTypeLabel.textAlignment = .center
        
        dailyTempLabel.textColor = .label
        dailyTempLabel.font = .systemFont(ofSize: 18, weight: .bold)
        dailyTempLabel.textAlignment = .center
    }
    
    /// Выполняет настройку констрейнтов.
    func setupConstraints() {
        locationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTempLabel.translatesAutoresizingMaskIntoConstraints = false
        cuttenrWeatherTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        dailyTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            locationNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            currentTempLabel.topAnchor.constraint(equalTo: locationNameLabel.bottomAnchor, constant: 7),
            currentTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cuttenrWeatherTypeLabel.topAnchor.constraint(equalTo: currentTempLabel.bottomAnchor, constant: 7),
            cuttenrWeatherTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            dailyTempLabel.topAnchor.constraint(equalTo: cuttenrWeatherTypeLabel.bottomAnchor, constant: 7),
            dailyTempLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            dailyTempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
