//
//  AlertTableViewCell.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import UIKit

// MARK: - AlertTableViewCell

final class AlertTableViewCell: UITableViewCell {
    
    // MARK: - Subview properties
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "square.and.arrow.down")
        return imageView
    }()
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.textColor = .black
        return label
    }()
    private let senderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.textColor = .black
        return label
    }()
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Private properties
    
    private let imageLoader = ImageLoader.shared
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        iconImageView.image = UIImage(systemName: "square.and.arrow.down")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(iconImageView, activate: [
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        contentView.addSubview(eventLabel, activate: [
            eventLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            eventLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            eventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        contentView.addSubview(senderLabel, activate: [
            senderLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            senderLabel.topAnchor.constraint(equalTo: eventLabel.topAnchor, constant: 20),
            senderLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        contentView.addSubview(durationLabel, activate: [
            durationLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            durationLabel.topAnchor.constraint(equalTo: senderLabel.topAnchor, constant: 20),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        contentView.addSubview(separatorView, activate: [
            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separatorView.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 24),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // MARK: - Public methods
    
    func configure(event: String, sender: String, duration: String, cellIndex: Int) {
        eventLabel.text = "Event: \(event)"
        senderLabel.text = "Sender: \(sender)"
        durationLabel.text = "Duration: \(duration)"
        imageLoader.loadImage(for: cellIndex) { data in
            DispatchQueue.main.async { [weak self] in
                self?.iconImageView.image = UIImage(data: data)
            }
        }
    }
}
