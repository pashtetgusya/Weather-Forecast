import Foundation

// MARK: - Safe subscript

extension Array {
    
    /// Сабскрипт, обеспечивающий безопасную работу с элементами массива.
    ///
    /// При попытке получения элемента по индексу, выходящему за пределы массива, вернет `nil`.
    /// При попытке сохранения элемента по индексу, выходящему за пределы массива, ничего не произойдет.
    subscript (safe index: Int) -> Element? {
        get {
            guard
                0 <= index,
                index < count
            else { return nil }
            
            return self[index]
        }
        
        set {
            guard
                let newValue,
                0 <= index,
                index < count,
                !isEmpty
            else { return }
            
            self[index] = newValue
        }
    }
}
