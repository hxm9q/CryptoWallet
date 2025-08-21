import SwiftUI

struct CoinListView: View {
    @ObservedObject var viewModel: CoinListViewModel
    
    private struct CoinListConstants {
        static let backgroundColor = Color(red: 255/255, green: 154/255, blue: 178/255)
        static let tableViewBackgroundColor = Color(red: 247/255, green: 247/255, blue: 250/255)
        static let learnMoreButtonBackgroundColor = Color(red: 250/255, green: 251/255, blue: 251/255)
        static let coinListImageSize: CGFloat = 242
    }
    
    var body: some View {
        
        ZStack {
            CoinListConstants.backgroundColor.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerSection
                
            }
        }
        .onTapGesture {
            viewModel.hideAllMenus()
        }
        .onAppear {
            viewModel.fetchCoins()
        }
    }
}

// MARK: - Header View
private extension CoinListView {
    
    var headerSection: some View {
        ZStack {
            VStack(spacing: 0) {
                topNavigationBar
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        affiliate
                        Spacer()
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 25)
            
            VStack {
                HStack {
                    Spacer()
                    coinListImage.offset(x: -15)
                }
                Spacer()
            }
            .padding(.top, 101)
        }
    }
    
    var topNavigationBar: some View {
        HStack {
            Text("Home")
                .foregroundStyle(.white)
                .font(.system(size: 32, weight: .semibold))
            
            Spacer()
            
            ZStack {
                Button {
                    viewModel.toggleRefreshLogoutMenu()
                } label: {
                    Image("threedots")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .frame(width: 48, height: 48)
                .background(.white.opacity(0.8))
                .clipShape(Circle())
                
                if viewModel.showRefreshLogoutMenu {
                    //                        refreshlogoutmenu
                }
            }
        }
        .padding(.top, 32)
    }
    
    var affiliate: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Affiliate program")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .semibold))
            
            Button {
                
            } label: {
                Text("Learn more")
                    .foregroundStyle(.black)
                    .font(.system(size: 14, weight: .semibold))
            }
            .frame(width: 127, height: 35)
            .background(CoinListConstants.learnMoreButtonBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(.top, 46)
    }
    
    var coinListImage: some View {
        Image("home_logo")
            .resizable()
            .scaledToFill()
            .frame(width: CoinListConstants.coinListImageSize, height: CoinListConstants.coinListImageSize)
            .clipped()
            .shadow(
                color: Color(red: 231/255, green: 68/255, blue: 109/255).opacity(0.5),
                radius: 20,
                x: -30,
                y: 30
            )
            .offset(x: 15, y: 21)
    }
}

// MARK: - Coin List Section
private extension CoinListView {
    
}


#Preview {
    CoinListView(viewModel: CoinListViewModel())
}
