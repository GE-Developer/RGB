//
//  ViewController.swift
//  RGB
//
//  Created by M I C H A E L on 23.03.2023.
//

import UIKit

final class RGBViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var colorView: UIView!
    
    @IBOutlet private var redLabel: UILabel!
    @IBOutlet private var greenLabel: UILabel!
    @IBOutlet private var blueLabel: UILabel!
    
    @IBOutlet private var redSlider: UISlider!
    @IBOutlet private var greenSlider: UISlider!
    @IBOutlet private var blueSlider: UISlider!
    
    @IBOutlet private var redTextField: UITextField!
    @IBOutlet private var greenTextField: UITextField!
    @IBOutlet private var blueTextField: UITextField!
    
    @IBOutlet private var hexLabel: UILabel!
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        redSlider.value = Float(mainColor.cgColor.components?[0] ?? 0)
        greenSlider.value = Float(mainColor.cgColor.components?[1] ?? 0)
        blueSlider.value = Float(mainColor.cgColor.components?[2] ?? 0)
    
        changeViewColor()
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
        
        hexLabel.text = hexString()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBAction Methods
    @IBAction func sliderAction(_ sender: UISlider) {
        changeViewColor()
        hexLabel.text = hexString()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    // MARK: - Private Methods
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func hexString() -> String {
        let hexString = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(redSlider.value * 255)),
            lroundf(Float(greenSlider.value * 255)),
            lroundf(Float(blueSlider.value * 255))
        )
        
        return "Hex Color: \(hexString)"
    }
}


extension RGBViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var currentValue = Float(textField.text ?? "0") ?? 0
        
        switch currentValue {
        case 0:
            textField.text = "0.00"
        case 1...:
            textField.text = "1.00"
            currentValue = 1
        default:
            textField.text = String(format: "%.2f", currentValue)
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            redLabel.text = string(from: redSlider)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            greenLabel.text = string(from: greenSlider)
        default:
            blueSlider.setValue(currentValue, animated: true)
            blueLabel.text = string(from: greenSlider)
        }
        
        changeViewColor()
        hexLabel.text = hexString()
    }
}
