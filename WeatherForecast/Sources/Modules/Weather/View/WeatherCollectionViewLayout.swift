import UIKit

// MARK: - Weather collection view layout

/// Лейаут коллекции отображения прогноза погоды.
final class WeatherCollectionViewLayout: UICollectionViewCompositionalLayout {
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init() {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 24
        
        super.init(
            sectionProvider: { sectionIndex, _ in
                switch sectionIndex {
                    case WeatherCollectionViewModel.Section.Kind.currentWeather.index:
                        Self.buildCurrentWeatherSection()
                    case WeatherCollectionViewModel.Section.Kind.hourlyWeather.index:
                        Self.buildHourlyWeatherSection()
                    case WeatherCollectionViewModel.Section.Kind.dailyWeather.index:
                        Self.buildDailyWeatherSection()
                    default: fatalError("unknown section")
                }
            },
            configuration: configuration
        )
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
}

// MARK: - Section build functions

private extension WeatherCollectionViewLayout {
    
    /// Создает секцию отображения текущего прогноза погоды.
    static func buildCurrentWeatherSection() -> NSCollectionLayoutSection {
        let itemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupLayoutSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    /// Создает секцию отображения почасового прогноза погоды.
    static func buildHourlyWeatherSection() -> NSCollectionLayoutSection {
        let itemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(150)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupLayoutSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 6
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    /// Создает секцию отображения прогноза погоды погоды по дням.
    static func buildDailyWeatherSection() -> NSCollectionLayoutSection {
        let itemLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupLayoutSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 6
        
        return section
    }
}
