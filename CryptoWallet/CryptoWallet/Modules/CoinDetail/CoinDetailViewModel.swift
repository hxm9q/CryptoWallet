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
        return "\(coin.change)"
    }
    
    var arrowImageName: String {
        return coin.isPositiveChange ? "arrow up" : "arrow down"
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
        case 0:
            return coin.supply1D
        case 1:
            return coin.supply7D
        case 2:
            return coin.supply1Y
        case 3:
            return coin.supplyEver
        default:
            return nil
        }
    }
    
    func selectedSupplyValue() -> Double? {
        return supplyValue(for: selectedIndex)
    }
    
    func coinData() -> Coin {
        return coin
    }
}
