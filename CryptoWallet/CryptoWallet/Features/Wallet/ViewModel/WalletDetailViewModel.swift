import UIKit

final class WalletDetailViewModel {
    
    weak var coordinator: WalletCoordinator?
    
    private let wallet: Wallet
    
    init(wallet: Wallet) {
        self.wallet = wallet
    }
    
    var walletTitle: String {
        return wallet.name
    }
    
    var amountInfo: String {
        return "\(wallet.amount) BTC"
    }
    
    var dateInfo: String {
        return "Date: \(wallet.date)"
    }
    
    func goBack() {
        coordinator?.goBackFromWalletDetail()
    }
}
