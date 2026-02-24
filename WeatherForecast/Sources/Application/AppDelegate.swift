import UIKit

// MARK: - Application delegate

@main final class AppDelegate: UIResponder {
    
    // MARK: Properties
    
    var window: UIWindow?
    
    private var appDIContainer: AppDIContainer?
    private var appCoordinator: Coordinator?
}

// MARK: - UI application delegate protocol implementation

extension AppDelegate: UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupAppDIContainer()
        setupAppCoordinator()
        setupAppRootViewController()
        
        return true
    }
}

// MARK: - Setup functions

private extension AppDelegate {
    
    /// Выполняет настройку контейнера с зависимостями приложения.
    func setupAppDIContainer() {
        appDIContainer = AppDIContainer()
    }
    
    /// Выполняет настройку координатора приложения.
    func setupAppCoordinator() {
        guard let appDIContainer else { return }
        
        let navController = UINavigationController()
        appCoordinator = AppCoordinator(
            di: appDIContainer,
            navController: navController
        )
        appCoordinator?.start()
    }
    
    /// Выполняет настройку главного контроллера приложения.
    func setupAppRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator?.navController
        window?.makeKeyAndVisible()
    }
}
