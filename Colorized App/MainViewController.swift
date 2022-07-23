//
//  MainViewController.swift
//  Colorized App
//
//  Created by Евгений Бияк on 23.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorizeViewController = segue.destination as? ColorizeViewController
        colorizeViewController?.delegate = self
        colorizeViewController?.color = view.backgroundColor
    }
    
}

extension MainViewController: ColorizeViewControllerDelegate {
    func updateViewColor(with color: UIColor) {
        view.backgroundColor = color
    }
}

