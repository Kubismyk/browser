//
//  TabBar.swift
//  browser
//
//  Created by Levan Charuashvili on 11.06.23.
//

import UIKit
import WebKit

protocol TabBarViewControllerDelegate: AnyObject {
    func goBack()
    func textFieldDidReturn(withText text: String)
    func goForward()
}
class TabBar: UITabBarController, UITabBarControllerDelegate,UITextFieldDelegate {
    
    private let textField = UITextField()
    private var textFieldBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0.0
    weak var tabBarDelegate: TabBarViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate of the tab bar controller to self
        self.delegate = self
        textField.delegate = self
        
        // Create view controllers for each tab
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        firstViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "arrow.left"), tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.view.backgroundColor = .green
        secondViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "arrow.right"), tag: 1)
        
        let thirdViewController = UIViewController()
        thirdViewController.view.backgroundColor = .blue
        thirdViewController.tabBarItem = UITabBarItem(title: "Tab 3", image: UIImage(systemName: "3.circle"), tag: 2)
        
        let fourthViewController = UIViewController()
        fourthViewController.view.backgroundColor = .blue
        fourthViewController.tabBarItem = UITabBarItem(title: "Tab 4", image: UIImage(systemName: "4.circle"), tag: 3)
        
        let fifthViewController = UIViewController()
        fifthViewController.view.backgroundColor = .blue
        fifthViewController.tabBarItem = UITabBarItem(title: "Tab 5", image: UIImage(systemName: "5.circle"), tag: 4)
        
        // Set the view controllers for the tab bar
        self.viewControllers = [firstViewController, secondViewController, thirdViewController,fourthViewController,fifthViewController]
        
        // Add the text field as a subview of the tab bar controller's view
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
           
        // Configure constraints for the text field
        textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -8)
        textFieldBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 30),
            textFieldBottomConstraint
        ])
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        keyboardHeight = keyboardFrame.height
        
        moveTextFieldWithKeyboard()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        keyboardHeight = 0.0
        
        moveTextFieldWithKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            tabBarDelegate?.textFieldDidReturn(withText: text)
        }
        return true
    }
    
    private func moveTextFieldWithKeyboard() {
        let safeAreaBottom = view.safeAreaInsets.bottom
        let tabBarHeight = tabBar.frame.height
        let textFieldBottomMargin: CGFloat = 2.0
        
        let keyboardOffset = keyboardHeight - safeAreaBottom + tabBarHeight + textFieldBottomMargin
        
        textField.transform = CGAffineTransform(translationX: 0, y: -keyboardOffset)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 0 {
            // Perform custom action for Tab 1
            performTab1Action()
            return false // Return false to prevent switching tabs
        } else if viewController.tabBarItem.tag == 1 {
            // Perform custom action for Tab 2
            performTab2Action()
            return false // Return false to prevent switching tabs
        }
        
        return true // Allow switching to other tabs by default
    }
    
    private func performTab1Action() {
        print("go back form page")
        tabBarDelegate?.goBack()
        // Add your custom code here
    }
    
    private func performTab2Action() {
        print("go forward")
        tabBarDelegate?.goForward()
        // Add your custom code here
    }
}
