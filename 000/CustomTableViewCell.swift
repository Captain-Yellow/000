//
//  CustomTableViewCell.swift
//  000
//
//  Created by Mohammad Afshar on 09/12/2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let cellIdentity = "CustomTableViewCell"
    var button: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.button = UIButton(type: .system)
        let myRandom = ["figure.dance", "figure.strengthtraining.functional", "figure.mixed.cardio", "figure.yoga", "figure.cooldown", "figure.core.training", "figure.wave", "figure.climbing", "figure.barre", "figure.cross.training", "figure.gymnastics"]
        let myColor: [UIColor] = [.systemYellow, .red, .purple, .green, .blue, .systemPink, .orange, .systemTeal, .cyan]
        button.setImage(UIImage(systemName: myRandom.randomElement()!), for: .normal)
        button.tintColor = myColor.randomElement()
        button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: contentView.bounds.width - 50, y: (contentView.bounds.height-30)/2, width: 30, height: contentView.bounds.height - 10)
        textLabel?.frame = CGRect(x: 10, y: (contentView.bounds.height-40)/2, width: contentView.bounds.width / 2, height: contentView.bounds.height - 10)
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print(sender.tag)
    }

}
