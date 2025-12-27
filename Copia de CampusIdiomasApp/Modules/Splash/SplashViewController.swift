//
//  SplashViewController.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 20/12/25.
//

import UIKit

final class SplashViewController: UIViewController {

    @IBOutlet private weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        logoImageView.image = UIImage(named: "LogoCIC")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            AppRouter.shared.showWelcome()
        }
    }
}
