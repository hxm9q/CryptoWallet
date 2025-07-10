import UIKit

class CoinDetailCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "CoinDetailCell"
    
    // MARK: - UI Components
    private let statisticLabel: UILabel = {
        let label = UILabel()
        label.text = "Market Statistic"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let capitalizationLabel: UILabel = {
        let label = UILabel()
        label.text = "Market capitalization"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let supplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Circulating Supply"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    private let capitalizationAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let supplyAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupLayout() {
        [statisticLabel, capitalizationLabel, supplyLabel, capitalizationAmountLabel, supplyAmountLabel].forEach {
            contentView.addSubview($0)
        }
        
        statisticLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(25)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(157)
            make.height.equalTo(30)
        }
        
        capitalizationLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(70)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(149)
            make.height.equalTo(21)
        }
        
        supplyLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(106)
            make.leading.equalTo(contentView.snp.leading).offset(25)
            make.width.equalTo(149)
            make.height.equalTo(21)
        }
        
        capitalizationAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(70)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
            make.height.equalTo(21)
        }
        
        supplyAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(106)
            make.trailing.equalTo(contentView.snp.trailing).offset(-25)
            make.height.equalTo(21)
        }
    }
    
    func configure(with coin: Coin) {
        capitalizationAmountLabel.text = "$" + coin.marketcapString
    }
    
    func configureSupply(with coin: Coin, value: Double?) {
        if let supply = value {
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 0
            
            let result = formatter.string(from: NSNumber(value: supply)) ?? "\(supply)"
            
            supplyAmountLabel.text = result + " \(coin.symbol)"
        } else {
            supplyAmountLabel.text = "nil"
        }
    }
}
