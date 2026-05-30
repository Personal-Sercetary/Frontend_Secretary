import SwiftUI
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Дозволяємо свайп тільки якщо в стеку більше одного екрану (щоб не закрити головний екран)
        return viewControllers.count > 1
    }
}
