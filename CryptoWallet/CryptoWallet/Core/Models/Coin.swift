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
    let marketcap: Double
    let marketcapString: String
    let supply1D: Double?
    let supply7D: Double?
    let supply1Y: Double?
    let supplyEver: Double?
    
    init(name: String, symbol: String, price: Double, change: Double, marketcap: Double,
         supply1D: Double?, supply7D: Double?, supply1Y: Double?, supplyEver: Double?) {
        self.name = name
        self.symbol = symbol
        self.image = UIImage(named: symbol.lowercased())
        
        let priceFormatter = NumberFormatter()
        priceFormatter.locale = Locale(identifier: "en_US")
        priceFormatter.numberStyle = .decimal
        priceFormatter.maximumFractionDigits = 2
        priceFormatter.minimumFractionDigits = 2
        self.price = priceFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        
        self.priceValue = price
        self.change = String(format: "%.2f%%", change)
        self.isPositiveChange = change >= 0
        
        self.marketcap = marketcap
        
        let capFormatter = NumberFormatter()
        capFormatter.locale = Locale(identifier: "en_US")
        capFormatter.numberStyle = .decimal
        capFormatter.maximumFractionDigits = 0
        self.marketcapString = capFormatter.string(from: NSNumber(value: marketcap)) ?? "\(marketcap)"
        
        self.supply1D = supply1D
        self.supply7D = supply7D
        self.supply1Y = supply1Y
        self.supplyEver = supplyEver
    }
}
