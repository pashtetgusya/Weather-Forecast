import UIKit

// MARK: - Weather view

/// Вью экрана прогноза погоды.
final class WeatherView: UIView {
    
    // MARK: Subviews
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: WeatherCollectionViewLayout()
    )
    
    // MARK: Properties
    
    let loadingConfiguration: UIContentUnavailableConfiguration = {
        var configuration = UIContentUnavailableConfiguration.loading()
        configuration.text = "Please wait..."
        configuration.secondaryText = "Fetching weather forecast."
        configuration.textProperties.color = .white
        configuration.secondaryTextProperties.color = .white
        
        return configuration
    }()
    var errorLoadingConfiguration: UIContentUnavailableConfiguration = {
        var buttonConfiguration = UIButton.Configuration.borderless()
        buttonConfiguration.title = "Retry"
        buttonConfiguration.image = UIImage(systemName: "arrow.clockwise")
        buttonConfiguration.baseForegroundColor = .label
        
        var configuration = UIContentUnavailableConfiguration.empty()
        configuration.text = "Oops..."
        configuration.secondaryText = "Failed to load weather forecast."
        configuration.textProperties.color = .label
        configuration.secondaryTextProperties.color = .label
        configuration.button = buttonConfiguration
        
        return configuration
    }()
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setupAppearance()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
}

// MARK: - Setup functions

private extension WeatherView {
    
    /// Выполняет добавление `view`-компонентов.
    func addSubviews() {
        addSubview(collectionView)
    }
    
    /// Выполняет настройку `view`-компонентов.
    func setupAppearance() {
        backgroundColor = .systemBackground
        
        collectionView.allowsSelection = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.registerCell(CurrentWeatherCell.self)
        collectionView.registerCell(HourlyWeatherCell.self)
        collectionView.registerCell(DailyWeatherCell.self)
    }
    
    /// Выполняет настройку констрейнтов.
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
