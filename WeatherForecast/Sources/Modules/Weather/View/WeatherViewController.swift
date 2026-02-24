import UIKit
import Combine

// MARK: - Weather view controller

/// Вью контроллер экрана прогноза погоды.
final class WeatherViewController: UIViewController {
    
    // MARK: Properties
    
    private let contentView: WeatherView
    private let dataSource: WeatherCollectionViewDataSource
    private let viewModel: WeatherViewModel
    private var cancellables: Set<AnyCancellable>
    
    // MARK: Initialization
    
    /// Создает новый экземпляр класса.
    init(viewModel: WeatherViewModel) {
        self.contentView = WeatherView()
        self.dataSource = WeatherCollectionViewDataSource(
            collectionView: self.contentView.collectionView
        )
        self.viewModel = viewModel
        self.cancellables = []
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { nil }
}

// MARK: - Life cycle

extension WeatherViewController {
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewBindings()
        setupViewModelBindings()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        viewModel.loadWeather()
    }
}

// MARK: - Setup functions

private extension WeatherViewController {
    
    /// Выполняет настройку подписок на события вью.
    func setupViewBindings() {
        contentView
            .errorLoadingConfiguration
            .buttonProperties
            .primaryAction = UIAction { [weak self] _ in
                self?.viewModel.loadWeather()
            }
    }
    
    /// Выполняет настройку подписок на события вью модели.
    func setupViewModelBindings() {
        viewModel
            .$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .idle:
                    self?.contentUnavailableConfiguration = nil
                case .loading:
                    self?.contentUnavailableConfiguration = self?.contentView.loadingConfiguration
                case .loaded(let weahterSections):
                    self?.contentUnavailableConfiguration = nil
                    self?.dataSource.update(with: weahterSections)
                case .errorLoading:
                    self?.contentUnavailableConfiguration = self?.contentView.errorLoadingConfiguration
                }
            }
            .store(in: &cancellables)
    }
}
