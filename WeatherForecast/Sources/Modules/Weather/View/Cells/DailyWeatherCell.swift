import UIKit
import Kingfisher

// MARK: - Daily weather cell

/// Ячейка отображения прогноза погоды за день.
final class DailyWeatherCell: UICollectionViewCell {
    
    // MARK: Subviews
    
    private let dayLabel = UILabel()
    private let minTempLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let iconImageView = UIImageView()
    
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
    required init?(coder: NSCoder) { nil }
}

// MARK: - Life cycle

extension DailyWeatherCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.kf.cancelDownloadTask()
    }
}

// MARK: - Configuration function

extension DailyWeatherCell {
    
    /// Выполнят настройку ячейке на основе переданной моделе.
    /// - Parameter model: модель для настройки ячейки.
    func setup(with model: WeatherModel.DailyWeahter) {
        let minTempMeasurement = Measurement(value: model.minTemperature, unit: UnitTemperature.celsius)
        let maxTempMeasurement = Measurement(value: model.maxTemperature, unit: UnitTemperature.celsius)
        
        self.dayLabel.text = model.date
        self.minTempLabel.text = measurementFormatter.string(from: minTempMeasurement)
        self.maxTempLabel.text = measurementFormatter.string(from: maxTempMeasurement)
        self.iconImageView.kf.setImage(with: model.iconURL)
    }
}

// MARK: - Setup functions

private extension DailyWeatherCell {
    
    /// Выполняет добавление `view`-компонентов.
    func addSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(minTempLabel)
        contentView.addSubview(maxTempLabel)
        contentView.addSubview(iconImageView)
    }
    
    /// Выполняет настройку `view`-компонентов.
    func setupAppearance() {
        contentView.backgroundColor = .systemGray4
        contentView.layer.cornerRadius = 20
        
        dayLabel.textColor = .label
        dayLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        minTempLabel.textAlignment = .right
        minTempLabel.textColor = .label
        minTempLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        maxTempLabel.textAlignment = .right
        maxTempLabel.textColor = .label
        maxTempLabel.font = .systemFont(ofSize: 14, weight: .bold)
        
        iconImageView.contentMode = .scaleAspectFit
    }
    
    /// Выполняет настройку констрейнтов.
    func setupConstraints() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            dayLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1 / 4),
            
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 4),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor),
            
            minTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            minTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            minTempLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            
            maxTempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            maxTempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            maxTempLabel.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 4),
            maxTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            maxTempLabel.widthAnchor.constraint(equalTo: minTempLabel.widthAnchor)
        ])
    }
}
