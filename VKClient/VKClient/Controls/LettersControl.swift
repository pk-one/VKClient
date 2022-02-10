//
//  CustomSearchControl.swift
//  VKClient
//
//  Created by Pavel Olegovich on 31.07.2021.
//

import UIKit

class LettersControl: UIControl {
    
    var selectedLetter: Int? = nil {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    private var buttonsLetters: [UIButton] = []
    private var stackView = UIStackView()
    
    ///создаем кнопки
    func setupBaseUI(with model: [GroupFriends]) {
        buttonsLetters.removeAll()
        for friend in model {
            let button = UIButton()
            button.setTitle(String(friend.firstLetter), for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.titleLabel?.font = .arial13()
            button.addTarget(self, action: #selector(selectNewLetter(_:)), for: .touchUpInside)
            buttonsLetters.append(button)
        }
        ///добавляем в стэк кнопки
        stackView = UIStackView(arrangedSubviews: buttonsLetters)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    ///получамем индекс кнопки
    @objc private func selectNewLetter(_ sender: UIButton) {
        guard let indexSection = buttonsLetters.firstIndex(of: sender) else { return }
        selectedLetter = indexSection
    }
}
