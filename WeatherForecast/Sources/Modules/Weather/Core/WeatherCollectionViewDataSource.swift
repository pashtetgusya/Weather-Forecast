import UIKit

// MARK: - Weather collection view data source

/// Источник данных коллекции отображения прогноза погоды.
final class WeatherCollectionViewDataSource: UICollectionViewDiffableDataSource<
    WeatherCollectionViewModel.Section.Kind,
    WeatherCollectionViewModel.Section.Row
> {
    
    // MARK: Typealiases
    
    typealias Snapshot = NSDiffableDataSourceSnapshot<
        WeatherCollectionViewModel.Section.Kind,
        WeatherCollectionViewModel.Section.Row
    >
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
                case .currentWeather(let model):
                    let cell: CurrentWeatherCell = collectionView.dequeue(for: indexPath)
                    cell.setup(with: model)
                    
                    return cell
                case .hourlyWeather(let model):
                    let cell: HourlyWeatherCell = collectionView.dequeue(for: indexPath)
                    cell.setup(with: model)
                    
                    return cell
                case .dailyWeather(let model):
                    let cell: DailyWeatherCell = collectionView.dequeue(for: indexPath)
                    cell.setup(with: model)
                    
                    return cell
            }
        }
    }
}

// MARK: - Update functions

extension WeatherCollectionViewDataSource {
    
    /// Выполняет обновление данных в коллекции.
    /// - Parameters:
    ///   - sections: новый список секций для отображения.
    ///   - animated: флаг анимированного обновления (по умолчанию `true`).
    func update(
        with sections: [WeatherCollectionViewModel.Section],
        animated: Bool = true
    ) {
        var snapshot = Snapshot()
        
        sections.forEach {
            snapshot.appendSections([$0.kind])
            snapshot.appendItems($0.rows, toSection: $0.kind)
        }
        
        apply(snapshot, animatingDifferences: animated)
    }
}
