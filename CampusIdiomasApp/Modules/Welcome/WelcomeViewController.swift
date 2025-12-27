//
//  WelcomeViewController.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 20/12/25.
//

import UIKit

final class WelcomeViewController: UIViewController {

    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var headerContainerView: UIView!



    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
            startButton.layer.cornerRadius = 10
            startButton.clipsToBounds = true

            mainImageView.image = UIImage(named: "BienvenidaImagen")
            mainImageView.contentMode = .scaleAspectFit

            // Logo superior
            logoImageView.image = UIImage(named: "LogoCICcompleto")
            logoImageView.contentMode = .scaleAspectFit
        
            // 🔥 RADIO SOLO ABAJO
            headerContainerView.layer.cornerRadius = 30
            headerContainerView.layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
            headerContainerView.layer.masksToBounds = true
        
            startButton.setTitle(
                NSLocalizedString("start_button", comment: "Botón para iniciar la app"),
                for: .normal
            )

        }

    @IBAction private func didTapStart(_ sender: UIButton) {
        print("✅ didTapStart fired")
        AppRouter.shared.showLogin()
    }


}

