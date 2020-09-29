//
//  NewServiceTableViewCell.swift
//  NewMassage
//
//  Created by Lewis Liu on 29/7/20.
//  Copyright © 2020 Lewis Liu. All rights reserved.
//

import UIKit

protocol NewServiceCellDelegate {
    func increaseNumber(cell: NewServiceTableViewCell,number : Int)
    func decreaseNumber(cell: NewServiceTableViewCell,number : Int)
}

class NewServiceTableViewCell: UITableViewCell {
    
    var delegate : NewServiceCellDelegate?
    let minValue = 0
    
    @objc func decreaseFunc() {
        changeQuantity(by: -1)
        
    }
    
    @objc func increaseFunc() {
        changeQuantity(by: 1)
    }
    
    
    func changeQuantity(by amount: Int) {
        var quality = Int(productQuantity.text!)!
        quality += amount
        if quality < minValue {
            quality = 0
            productQuantity.text = "0"
        } else {
            productQuantity.text = "\(quality)"
        }
        delegate?.decreaseNumber(cell: self, number: quality)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    var service : Service? {
        didSet {
            let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
            let homeImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfiguration)
            serviceImage.image = homeImage //service?.images[0]
            serviceNameLabel.text = service?.name
            serviceDescriptionLabel.text = service?.benefits
        }
    }
    
    
    private let serviceNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let serviceDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let decreaseButton : UIButton = {
        let btn = UIButton(type: .custom)
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .black)
        let homeImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfiguration)
        
        btn.setImage(homeImage, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    private let increaseButton : UIButton = {
        let btn = UIButton(type: .custom)
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .black)
        let homeImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfiguration)
        btn.setImage(homeImage, for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    var productQuantity : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        return label
        
    }()
    
    private let serviceImage : UIImageView = {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let homeImage = UIImage(systemName: "house", withConfiguration: homeSymbolConfiguration)
        let imgView = UIImageView(image: homeImage)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(serviceImage)
        addSubview(serviceNameLabel)
        addSubview(serviceDescriptionLabel)
        addSubview(decreaseButton)
        addSubview(productQuantity)
        addSubview(increaseButton)
        
        serviceImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        serviceNameLabel.anchor(top: topAnchor, left: serviceImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        serviceDescriptionLabel.anchor(top: serviceNameLabel.bottomAnchor, left: serviceImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        
        let stackView = UIStackView(arrangedSubviews: [decreaseButton,productQuantity,increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: serviceNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        
        increaseButton.addTarget(self, action: #selector(increaseFunc), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseFunc), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
