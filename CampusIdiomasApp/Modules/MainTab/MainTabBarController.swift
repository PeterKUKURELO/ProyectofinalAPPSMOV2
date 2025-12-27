import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureTabs()
    }

    private func configureAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.08)

        let selectedColor = UIColor(red: 147/255, green: 2/255, blue: 150/255, alpha: 1)
        let normalColor = UIColor.black.withAlphaComponent(0.7)

        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]

        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) { tabBar.scrollEdgeAppearance = appearance }
        tabBar.isTranslucent = true
    }

    func resizedImage(_ image: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? image
    }

    private func configureTabs() {
        let iconSize = CGSize(width: 25, height: 25)
        
        let home = UIStoryboard(name: "Home", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardID.homeVC)

        let carnet = UIStoryboard(name: "Carnet", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardID.carnetVC)

        let settings = UIStoryboard(name: "Settings", bundle: nil)
            .instantiateViewController(withIdentifier: StoryboardID.settingsVC)

        let homeNav = UINavigationController(rootViewController: home)
        let carnetNav = UINavigationController(rootViewController: carnet)
        let settingsNav = UINavigationController(rootViewController: settings)

        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: resizedImage(UIImage(named: "Home")!, size: iconSize),
            selectedImage: resizedImage(UIImage(named: "Home")!, size: iconSize)
        )
        
        carnetNav.tabBarItem = UITabBarItem(
            title: "Carnet",
            image: resizedImage(UIImage(named: "User")!, size: iconSize),
            selectedImage: resizedImage(UIImage(named: "User")!, size: iconSize)
        )
        
        settingsNav.tabBarItem = UITabBarItem(
            title: "Ajustes",
            image: resizedImage(UIImage(named: "Config")!, size: iconSize),
            selectedImage: resizedImage(UIImage(named: "Config")!, size: iconSize)
        )
        
        viewControllers = [homeNav, carnetNav, settingsNav]
    }

}
