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
        
        self.price = priceFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        self.priceValue = price
        self.change = String(format: "%.2f%%", change)
        self.isPositiveChange = change >= 0
        
        self.marketcap = marketcap
        self.marketcapString = capFormatter.string(from: NSNumber(value: marketcap)) ?? "\(marketcap)"
        
        self.supply1D = supply1D
        self.supply7D = supply7D
        self.supply1Y = supply1Y
        self.supplyEver = supplyEver
    }
    
    private let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    private let capFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}
