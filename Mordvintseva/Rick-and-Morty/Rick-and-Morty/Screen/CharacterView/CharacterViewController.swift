//
//  CharacterViewController.swift
//  Rick-and-Morty
//
//  Created by Mordvintseva Alena on 18/03/2019.
//  Copyright © 2019 Mordvintseva Alena. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet private var infoTable: UITableView!
    @IBOutlet private var image: UIImageView!
    private let infoCellIdentifier = "infoCell"
    private var character: CharacterRecord!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = character.name
        self.infoTable.dataSource = self
        self.infoTable.tableFooterView = UIView()
        let minSide = min(image.frame.height, image.frame.height)
        image.getImageByURL(url: URL(string: character.image)!, size: CGSize(width: minSide, height: minSide))
    }

    private enum CharacterInfo: Int, CaseIterable {
        case status = 0
        case species, type, gender
    }

    func setCharacter(character: CharacterRecord) {
        self.character = character
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharacterInfo.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.infoTable.dequeueReusableCell(withIdentifier: infoCellIdentifier, for: indexPath)
        guard let num = CharacterInfo(rawValue: indexPath.row) else { return cell }

        let value: String
        switch num {
        case .status:
            value = self.character.status
        case .species:
            value = self.character.species
        case .type:
            value = self.character.type
        case .gender:
            value = self.character.gender
        }

        cell.textLabel?.text = String(describing: num)
        cell.detailTextLabel?.text = value
        return cell
    }
}
