import UIKit

class CoinCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "CoinCell"
    
    // MARK: - UI Components
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bitcoin")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .right
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    private let changeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    private let changeStackView = UIStackView()
    
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
        [coinImageView, leftStackView, rightStackView].forEach {
            contentView.addSubview($0)
        }
        
        coinImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(25)
            make.centerY.equalToSuperview()
        }
        
        leftStackView.axis = .vertical
        leftStackView.spacing = 6
        leftStackView.alignment = .leading
        leftStackView.addArrangedSubview(nameLabel)
        leftStackView.addArrangedSubview(tickerLabel)
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalTo(coinImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        changeArrowImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
        }
        
        changeStackView.axis = .horizontal
        changeStackView.spacing = 5
        changeStackView.alignment = .center
        changeStackView.addArrangedSubview(changeArrowImageView)
        changeStackView.addArrangedSubview(changeLabel)
        
        rightStackView.axis = .vertical
        rightStackView.spacing = 6
        rightStackView.alignment = .trailing
        rightStackView.addArrangedSubview(priceLabel)
        rightStackView.addArrangedSubview(changeStackView)
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = "\(coin.name)"
        tickerLabel.text = "\(coin.symbol)"
        priceLabel.text = "$" + coin.price
        
        if let change24HString = coin.change24HString {
            changeLabel.text = change24HString
            changeLabel.textColor = .lightGray
            changeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            
            let arrowImageName = coin.isPositiveChange(for: 0) ? "arrow up" : "arrow down"
            changeArrowImageView.image = UIImage(named: arrowImageName)
            changeArrowImageView.isHidden = false
        } else {
            changeLabel.text = "N/A"
            changeLabel.textColor = .lightGray
            changeLabel.font = UIFont.italicSystemFont(ofSize: 14)
            changeArrowImageView.isHidden = true
        }
        
        coinImageView.image = coin.image
    }
}
