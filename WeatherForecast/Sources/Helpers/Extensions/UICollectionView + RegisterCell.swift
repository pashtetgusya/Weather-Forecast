import UIKit

// MARK: - UI collection view register cell functions

extension UICollectionView {
    
    /// Выполняет регистрацию класса ячейки для последующего использования в коллекции.
    /// - Parameter cell: класс ячейки, который необходимо зарегистрировать.
    func registerCell(_ cell: UICollectionViewCell.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    /// Выполняет регистрацию нескольких классов ячеек для последующего использования в коллекции.
    /// - Parameter cells: классы ячейки, которые необходимо зарегистрировать.
    func registerCells(_ cells: UICollectionViewCell.Type...) {
        cells.forEach { registerCell($0) }
    }
}
