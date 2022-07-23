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
    @IBOutlet weak var paintedView: UIView!
    
    @IBOutlet weak var redComponentLabel: UILabel!
    @IBOutlet weak var greenComponentLabel: UILabel!
    @IBOutlet weak var blueComponentLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    // MARK: - Properties
    var color: UIColor!
    
    weak var delegate: ColorizeViewControllerDelegate?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func clearButtonTapped() {
        updateViews(withColor: .white)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.updateViewColor(with: paintedView.backgroundColor!)
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews(withColor color: UIColor) {
        paintedView.backgroundColor = color
        
        redComponentLabel.text = String(format:"%.2f", color.rgba.red)
        greenComponentLabel.text = String(format:"%.2f", color.rgba.green)
        blueComponentLabel.text = String(format:"%.2f", color.rgba.blue)
        
        redSlider.value = Float(color.rgba.red)
        greenSlider.value = Float(color.rgba.green)
        blueSlider.value = Float(color.rgba.blue)
    }
}
