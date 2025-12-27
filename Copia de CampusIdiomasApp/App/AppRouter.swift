//
//  AppRouter.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 20/12/25.
//

import UIKit

final class AppRouter {

    static let shared = AppRouter()
    private init() {}

    private weak var window: UIWindow?

    func setWindow(_ window: UIWindow?) {
        self.window = window
    }

    // MARK: - Flow
    func start() {
        showSplash()
    }

    func showSplash() {
        let vc = instantiateVC(
            storyboard: StoryboardName.splash,
            id: StoryboardID.splashVC
        )
        setRoot(vc, animated: false)
    }
    
    func showWelcome() {
        let vc = instantiateVC(
            storyboard: StoryboardName.welcome,
            id: StoryboardID.welcomeVC
        )
        setRoot(vc, animated: true)
    }


    func showInitialFlow() {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: DefaultsKeys.hasSeenOnboarding)
        let isLoggedIn = UserDefaults.standard.bool(forKey: DefaultsKeys.isLoggedIn)

        if !hasSeenOnboarding {
            showOnboarding()
            return
        }

        if !isLoggedIn {
            showLogin()
            return
        }

        showMainTab()
    }

    func showOnboarding() {
        let vc = instantiateVC(
            storyboard: StoryboardName.onboarding,
            id: StoryboardID.onboardingVC
        )
        setRoot(vc, animated: true)
    }

    func showLogin() {
        let vc = instantiateVC(
            storyboard: StoryboardName.auth,
            id: StoryboardID.loginVC
        )
        setRoot(vc, animated: true)
    }

    func showMainTab() {
        let vc = instantiateVC(
            storyboard: StoryboardName.mainTab,
            id: StoryboardID.mainTabVC
        )
        setRoot(vc, animated: true)
    }

    // MARK: - Helpers
    private func instantiateVC(storyboard name: String, id: String) -> UIViewController {
        let sb = UIStoryboard(name: name, bundle: nil)
        return sb.instantiateViewController(withIdentifier: id)
    }



    private func setRoot(_ viewController: UIViewController, animated: Bool) {
        guard let window else { return }

        if animated {
            UIView.transition(with: window,
                              duration: 0.25,
                              options: [.transitionCrossDissolve],
                              animations: {
                                  window.rootViewController = viewController
                              },
                              completion: nil)
        } else {
            window.rootViewController = viewController
        }

        window.makeKeyAndVisible()
    }
}

// MARK: - Safe instantiate helper
private extension UIStoryboard {
    func instantiateViewControllerSafe(withIdentifier identifier: String) -> UIViewController? {
        // instantiateViewController(withIdentifier:) crashea si no existe.
        // Este wrapper permite capturar errores de forma controlada.
        return instantiateViewController(withIdentifier: identifier)
    }
}
