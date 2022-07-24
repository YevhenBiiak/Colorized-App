//
//  ColorizeViewController.swift
//  Colorized App
//
//  Created by Евгений Бияк on 23.07.2022.
//

import UIKit

protocol ColorizeViewControllerDelegate: AnyObject {
    func updateViewColor(with color: UIColor)
}

class ColorizeViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warninLabel: UILabel!
    
    @IBOutlet weak var paintedView: UIView!
    
    @IBOutlet weak var redComponentLabel: UILabel!
    @IBOutlet weak var greenComponentLabel: UILabel!
    @IBOutlet weak var blueComponentLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    // MARK: - Properties
    var color: UIColor!
    
    weak var delegate: ColorizeViewControllerDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        warningView.alpha = 0
        
        setupTextFields()
        updateViews(withColor: color)
    }
    
    override func viewDidLayoutSubviews() {
        paintedView.layer.cornerRadius = 15
        paintedView.layer.borderWidth = 1
        paintedView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    // MARK: - Actioins
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        var red, green, blue: CGFloat
        switch sender.tag {
        case 0:
            red = CGFloat(sender.value)
            green = CGFloat(greenSlider.value)
            blue = CGFloat(blueSlider.value)
        case 1:
            red = CGFloat(redSlider.value)
            green = CGFloat(sender.value)
            blue = CGFloat(blueSlider.value)
        default:
            red = CGFloat(redSlider.value)
            green = CGFloat(greenSlider.value)
            blue = CGFloat(sender.value)
        }
        updateViews(withColor: UIColor(red: red, green: green, blue: blue, alpha: 1))
    }
    
    @IBAction func whiteButtonTapped() {
        updateViews(withColor: .white)
    }
    
    @IBAction func blackButtonTapped() {
        updateViews(withColor: .black)
    }
    
    @IBAction func randomButtonTapped() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        updateViews(withColor: UIColor(red: red, green: green, blue: blue, alpha: 1))
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.updateViewColor(with: paintedView.backgroundColor!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let red = Float(redTextField.text!.isEmpty ? "0" : redTextField.text!), red <= 1.0 else {
            showWarning("Red component is should be from 0.0 to 1.0")
            return
        }
        guard let green = Float(greenTextField.text!.isEmpty ? "0" : greenTextField.text!), green <= 1.0 else {
            showWarning("Green component is should be from 0.0 to 1.0")
            return
        }
        guard let blue = Float(blueTextField.text!.isEmpty ? "0" : blueTextField.text!), blue <= 1.0 else {
            showWarning("Blue component is should be from 0.0 to 1.0")
            return
        }
        hideWorning()
        updateViews(withColor: UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))
    }
}

// MARK: Private methods
extension ColorizeViewController {
    private func setupTextFields() {
        redTextField.addKeyboardToolbarButton(
            UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(dismissKeyboard)),
            position: .right)
        greenTextField.addKeyboardToolbarButton(
            UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(dismissKeyboard)),
            position: .right)
        blueTextField.addKeyboardToolbarButton(
            UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(dismissKeyboard)),
            position: .right)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateViews(withColor color: UIColor) {
        paintedView.backgroundColor = color
        
        redComponentLabel.text = String(format:"%.2f", color.rgba.red)
        greenComponentLabel.text = String(format:"%.2f", color.rgba.green)
        blueComponentLabel.text = String(format:"%.2f", color.rgba.blue)
        
        redSlider.value = Float(color.rgba.red)
        greenSlider.value = Float(color.rgba.green)
        blueSlider.value = Float(color.rgba.blue)
        
        if !redTextField.isFirstResponder {
            redTextField.text = String(format:"%.2f", color.rgba.red)
        }
        if !greenTextField.isFirstResponder {
            greenTextField.text = String(format:"%.2f", color.rgba.green)
        }
        if !blueTextField.isFirstResponder {
            blueTextField.text = String(format:"%.2f", color.rgba.blue)
        }
    }
    
    private func showWarning(_ text: String) {
        warninLabel.text = text
        UIView.animate(withDuration: 0.3) {
            self.warningView.alpha = 1
        }
    }
    private func hideWorning() {
        UIView.animate(withDuration: 0.3) {
            self.warningView.alpha = 0
        }
    }
}
