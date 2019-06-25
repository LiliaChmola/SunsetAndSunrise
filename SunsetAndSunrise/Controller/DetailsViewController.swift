//
//  DetailsViewController.swift
//  SunsetAndSunrise
//
//  Created by Chmola Lilia on 6/25/19.
//  Copyright © 2019 Lilia. All rights reserved.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private let networkManager = NetworkManager()
    private var details: Details?
    var latitude: Double!
    var longitude: Double!
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getDetailsFor(latitude: latitude, longitude: longitude) { [weak self] (details) in
            self?.details = details
            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if details == nil {
            return 0
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let detailCell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell {
            
            switch indexPath.row {
            case 0:
                detailCell.leftLabel.text = "First light"
                detailCell.rightLabel.text = details?.civilTwilightEnd
            case 1:
                detailCell.leftLabel.text = "Sunrise"
                detailCell.rightLabel.text = details?.sunrise
            case 2:
                detailCell.leftLabel.text = "Sunset"
                detailCell.rightLabel.text = details?.civilTwilightEnd
            case 3:
                detailCell.leftLabel.text = "Last light"
                detailCell.rightLabel.text = details?.astronomicalTwilightEnd
            case 4:
                if let daylightCell = tableView.dequeueReusableCell(withIdentifier: "DaylightTableViewCell", for: indexPath) as? DaylightTableViewCell {
                    daylightCell.daylightLabel.text = details?.dayLength
                    return daylightCell
                }
            default:
                return UITableViewCell()
            }
            return detailCell
        }
        return UITableViewCell()
    }
}

