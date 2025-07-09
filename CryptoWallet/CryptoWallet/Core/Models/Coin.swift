import Foundation
import UIKit

struct Coin {
    let name: String
    let symbol: String
    let image: UIImage?
    let price: String
    let priceValue: Double
    let change: String
    let isPositiveChange: Bool
    
    init(name: String, symbol: String, price: Double, change: Double) {
        self.name = name
        self.symbol = symbol
        self.image = UIImage(named: symbol.lowercased())
        self.price = String(format: "%.2f", price)
        self.priceValue = price
        self.change = String(format: "%.2f%%", change)
        self.isPositiveChange = change >= 0
    }
}
