import Foundation
import UIKit

final class CoinDetailViewModel {
    
    private let coin: Coin
    private let timeFilterSections = ["24H", "1W", "1Y", "ALL", "Point"]
    
    private var selectedIndex: Int = 0
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var displayName: String {
        return "\(coin.name) (\(coin.symbol.uppercased()))"
    }
    
    var displayPrice: String {
        return coin.price
    }
    
    var displayChange: String {
        guard let changeString = coin.getChangeString(for: selectedIndex) else {
            return "N/A"
        }
        return changeString
    }
    
    var arrowImageName: String {
        coin.isPositiveChange(for: selectedIndex) ? "arrow up" : "arrow down"
    }
    
    var timeFilters: [String] {
        return timeFilterSections
    }
    
    func numberOfRows() -> Int {
        return 1
    }
    
    func supplyValue(for index: Int) -> Double? {
        selectedIndex = index
        switch index {
        case 0: return coin.supply1D
        case 1: return coin.supply7D
        case 2: return coin.supply1Y
        case 3: return coin.supplyEver
        default: return nil
        }
    }
    
    func selectedSupplyValue() -> Double? {
        return supplyValue(for: selectedIndex)
    }
    
    func changeValue(for index: Int) -> Double? {
        switch index {
        case 0: return coin.change24H
        case 1: return coin.change7D
        case 2: return coin.change1Y
        case 3: return coin.changeEver
        default: return nil
        }
    }
    
    func selectedChangeValue() -> Double? {
        return changeValue(for: selectedIndex)
    }
    
    func selectedChangeString() -> String? {
        return coin.getChangeString(for: selectedIndex)
    }
    
    func isSelectedChangePositive() -> Bool {
        return coin.isPositiveChange(for: selectedIndex)
    }
    
    func updateSelectedIndex(_ index: Int) {
        selectedIndex = index
    }
    
    func coinData() -> Coin {
        return coin
    }
}
