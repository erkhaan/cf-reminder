//
//  ContestViewController.swift
//  cf-reminder
//
//  Created by Erkhaan  on 25.10.2022.
//

import UIKit

final class ContestViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        networkManager.getContests { contests, error in
            if let error = error {
                print(error)
            }
            if let contests = contests {
                print(contests.first?.name)
            }
        }
    }
}

