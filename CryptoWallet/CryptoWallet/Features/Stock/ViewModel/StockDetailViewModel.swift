import Foundation

final class StockDetailViewModel {
    
    weak var coordinator: StockCoordinator?
    
    private let stock: Stock
    
    init(stock: Stock) {
        self.stock = stock
    }
    
    var detailTitle: String {
        return "\(stock.name) (\(stock.symbol))"
    }
    
    var priceInfo: String {
        return "Current Price: $\(String(format: "%.2f", stock.price))"
    }
    
    func goBack() {
        coordinator?.goBackFromStockDetail()
    }
}
