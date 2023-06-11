//
//  TabBar.swift
//  browser
//
//  Created by Levan Charuashvili on 11.06.23.
//

import UIKit

class TabBar: UITabBarController {
    
    private let textField = UITextField()
    private var textFieldBottomConstraint: NSLayoutConstraint!
    private var keyboardHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create view controllers for each tab
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
        firstViewController.tabBarItem = UITabBarItem(title: "Tab 1", image: UIImage(systemName: "1.circle"), tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.view.backgroundColor = .green
        secondViewController.tabBarItem = UITabBarItem(title: "Tab 2", image: UIImage(systemName: "2.circle"), tag: 1)
        
        let thirdViewController = UIViewController()
        thirdViewController.view.backgroundColor = .blue
        thirdViewController.tabBarItem = UITabBarItem(title: "Tab 3", image: UIImage(systemName: "3.circle"), tag: 2)
        
        // Set the view controllers for the tab bar
        self.viewControllers = [firstViewController, secondViewController, thirdViewController]
        
        // Add the text field as a subview of the tab bar controller's view
        textField.borderStyle = .roundedRect
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
           
           // Configure constraints for the text field
        let textFieldBottomConstraint = textField.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -8)
        textFieldBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldBottomConstraint

        ])
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
    
    private func moveTextFieldWithKeyboard() {
        let safeAreaBottom = view.safeAreaInsets.bottom
        let tabBarHeight = tabBar.frame.height
        let textFieldBottomMargin: CGFloat = 8.0
        
        let keyboardOffset = keyboardHeight - safeAreaBottom + tabBarHeight + textFieldBottomMargin
        
        textField.transform = CGAffineTransform(translationX: 0, y: -keyboardOffset)
    }

}
