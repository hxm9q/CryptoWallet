import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    
    var body: some View {
        HStack() {
            logoImage
            
            VStack(alignment: .leading, spacing: 6) {
                nameText
                symbolText
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                priceText
                changeView
            }
        }
//        .padding(.horizontal, 25)
        .frame(height: 70)
        .background(Color.clear)
        .contentShape(Rectangle())
    }
}

// MARK: - Row Components
private extension CoinRowView {
    
    var logoImage: some View {
        Group {
            if let image = coin.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
    
    var nameText: some View {
        Text(coin.name)
            .foregroundStyle(.black)
            .font(.system(size: 18, weight: .semibold))
    }
    
    var symbolText: some View {
        Text(coin.symbol)
            .foregroundStyle(.gray.opacity(0.7))
            .font(.system(size: 14, weight: .regular))
    }
    
    var priceText: some View {
        Text("$\(coin.price)")
            .foregroundColor(.black)
            .font(.system(size: 18, weight: .semibold))
    }
    
    @ViewBuilder
    var changeView: some View {
        if let change24HString = coin.change24HString {
            HStack(spacing: 5) {
                let arrowImage = coin.isPositiveChange(for: 0) ? "arrow up" : "arrow down"
                Image(arrowImage)
                    .resizable()
                    .frame(width: 12, height: 12)
                
                Text(change24HString)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
            }
        } else {
            Text("N/A")
                .font(.system(size: 14, design: .serif))
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        CoinRowView(coin: Coin(
            name: "Bitcoin",
            symbol: "BTC",
            price: 45000.50,
            change24H: nil,
            change7D: -1.2,
            change1Y: nil,
            changeEver: 120.5,
            marketcap: 231233,
            supply1D: nil,
            supply7D: 7,
            supply1Y: 365,
            supplyEver: 1421421
        ))
        
        CoinRowView(coin: Coin(
            name: "Ethereum",
            symbol: "ETH",
            price: 3200.75,
            change24H: -1.8,
            change7D: 3.2,
            change1Y: nil,
            changeEver: 80.2,
            marketcap: 185432,
            supply1D: nil,
            supply7D: 5,
            supply1Y: 180,
            supplyEver: 987654
        ))
    }
    .padding()
    .background(.gray.opacity(0.2))
    .clipShape(RoundedRectangle(cornerRadius: 16))
}
