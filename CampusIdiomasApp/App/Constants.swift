//
//  Constants.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 20/12/25.
//

import Foundation

enum StoryboardName {
    static let splash = "Splash"
    static let welcome = "Welcome"
    static let auth = "Auth"
    static let onboarding = "Onboarding"
    static let mainTab = "MainTab"
}

enum StoryboardID {
    static let splashVC = "SplashViewController"
    static let welcomeVC = "WelcomeViewController"
    static let onboardingVC = "OnboardingViewController"
    static let loginVC = "LoginViewController"
    
    static let mainTabVC = "MainTabBarController"

       // Tabs
    static let homeVC = "HomeViewController"
    static let carnetVC = "CarnetViewController"
    static let settingsVC = "SettingsViewController"
}

enum DefaultsKeys {
    static let hasSeenOnboarding = "hasSeenOnboarding"
    static let isLoggedIn = "isLoggedIn" // para demo; luego lo cambias por token/keychain si deseas
}

