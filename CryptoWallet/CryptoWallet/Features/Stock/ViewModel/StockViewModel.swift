import Foundation

final class StockViewModel {
    
    weak var coordinator: StockCoordinator?
    
    let title: String
    var stocks: [Stock] = []
    
    init(title: String) {
        self.title = title
    }
    
    func loadStocks() {
        stocks = [ Stock(name: "Apple Inc.", symbol: "AAPL", price: 150.25) ]
    }
    
    func showStockDetail() {
        let appleStock = stocks[0]
        coordinator?.showStockDetail(stock: appleStock)
    }
}
