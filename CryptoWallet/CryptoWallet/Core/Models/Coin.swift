import Foundation
import UIKit

struct Coin {
    let name: String
    let symbol: String
    let image: UIImage?
    
    let price: String
    let priceValue: Double
    
    let change24H: Double?
    let change7D: Double?
    let change1Y: Double?
    let changeEver: Double?
    
    let change24HString: String?
    let change7DString: String?
    let change1YString: String?
    let changeEverString: String?
    
    let marketcap: Double
    let marketcapString: String
    
    let supply1D: Double?
    let supply7D: Double?
    let supply1Y: Double?
    let supplyEver: Double?
    
    init(name: String, symbol: String, price: Double,
         change24H: Double?, change7D: Double?, change1Y: Double?, changeEver: Double?,
         marketcap: Double,
         supply1D: Double?, supply7D: Double?, supply1Y: Double?, supplyEver: Double?) {
        
        self.name = name
        self.symbol = symbol
        self.image = UIImage(named: symbol.lowercased())
        
        self.price = priceFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        self.priceValue = price
        
        self.change24H = change24H
        self.change7D = change7D
        self.change1Y = change1Y
        self.changeEver = changeEver
        
        self.change24HString = change24H != nil ? String(format: "%.2f%%", change24H!) : nil
        self.change7DString = change7D != nil ? String(format: "%.2f%%", change7D!) : nil
        self.change1YString = change1Y != nil ? String(format: "%.2f%%", change1Y!) : nil
        self.changeEverString = changeEver != nil ? String(format: "%.2f%%", changeEver!) : nil
        
        self.marketcap = marketcap
        self.marketcapString = capFormatter.string(from: NSNumber(value: marketcap)) ?? "\(marketcap)"
        
        self.supply1D = supply1D
        self.supply7D = supply7D
        self.supply1Y = supply1Y
        self.supplyEver = supplyEver
    }
    
    func getChange(for index: Int) -> Double? {
        switch index {
        case 0: return change24H
        case 1: return change7D
        case 2: return change1Y
        case 3: return changeEver
        default: return nil
        }
    }
    
    func getChangeString(for index: Int) -> String? {
        switch index {
        case 0: return change24HString
        case 1: return change7DString
        case 2: return change1YString
        case 3: return changeEverString
        default: return nil
        }
    }
    
    func isPositiveChange(for index: Int) -> Bool {
        guard let change = getChange(for: index) else { return false }
        return change >= 0
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
