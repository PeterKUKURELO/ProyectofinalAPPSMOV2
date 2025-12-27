//
//  ClassTodayCellTableViewCell.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 27/12/25.
//

import UIKit

class ClassTodayCellTableViewCell: UITableViewCell {
    
    static let identifier = "ClassTodayCellTableViewCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var timeIcon: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    @IBOutlet private weak var locationIcon: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!

    @IBOutlet private weak var roomIcon: UIImageView!
    @IBOutlet private weak var roomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        cardView.layer.cornerRadius = 18
        cardView.clipsToBounds = true

        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)

        let purple = UIColor(red: 147/255, green: 2/255, blue: 150/255, alpha: 1)

        [timeIcon, locationIcon, roomIcon].forEach {
            $0?.tintColor = purple
        }

        [timeLabel, locationLabel, roomLabel].forEach {
            $0?.textColor = UIColor.black.withAlphaComponent(0.75)
            $0?.font = .systemFont(ofSize: 10, weight: .medium)
        }
        roomLabel.numberOfLines = 1
        locationLabel.numberOfLines = 1

        // Room NO se comprime
        roomLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        roomLabel.setContentHuggingPriority(.required, for: .horizontal)

        // Location sí puede comprimirse
        locationLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        locationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)


        // SF Symbols (si usas tus assets, cambia aquí)
        timeIcon.image = UIImage(named: "time")
        locationIcon.image = UIImage(named: "location")
        roomIcon.image = UIImage(named: "Door") // o laptop
    }

    func configure(with item: TodayClassItem, row: Int) {
        titleLabel.text = item.title
        timeLabel.text = item.time
        locationLabel.text = item.location
        roomLabel.text = item.roomOrMode

        // Alternar fondo: par = FFF1FF, impar = FFFFFF
        let lilac = UIColor(red: 255/255, green: 241/255, blue: 255/255, alpha: 1) // #FFF1FF
        cardView.backgroundColor = (row % 2 == 0) ? lilac : .white

        // Ícono según modalidad
        if item.roomOrMode.lowercased().contains("virtual") {
            roomIcon.image = UIImage(named: "laptop")
        } else {
            roomIcon.image = UIImage(named: "Door")
        }
    }

}
