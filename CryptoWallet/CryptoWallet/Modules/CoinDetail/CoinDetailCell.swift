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
//        label.text = "\())" Добавить капитализацию в структуру Coin
        return label
    }()
    
    private let supplyAmountLabel: UILabel = {
        let label = UILabel()
//        label.text = "\())" Добавить supply в структуру Coin
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
        [statisticLabel, capitalizationLabel].forEach {
            contentView.addSubview($0)
        }
        
        statisticLabel.snp.makeConstraints { make in
            
        }
    }
    
    func configure(with coin: Coin) {
        capitalizationLabel.text = "" // Добавить из API
    }
}
