//
//  RGBViewController.swift
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
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    var delegate: RGBViewControllerDelegate!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = Float(CIColor(color: mainColor).red)
        greenSlider.value = Float(CIColor(color: mainColor).green)
        blueSlider.value = Float(CIColor(color: mainColor).blue)

        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
        
        changeViewColor()
    }
    
    // MARK: - IBAction Methods
    @IBAction func sliderAction(_ sender: UISlider) {
        changeViewColor()
        
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
    
    @IBAction func doneAction() {
        if let color = colorView.backgroundColor {
            delegate.updateColor(color: color)
        }
        dismiss(animated: true)
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
}

// MARK: - UITextFieldDelegate
extension RGBViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupDoneButton(for: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = Float(textField.text ?? "0") ?? 0
        textField.text = value > 1 ? "1.00" : String(format: "%.2f", value)
        
        switch textField {
        case redTextField:
            redSlider.value = value
            redLabel.text = string(from: redSlider)
        case greenTextField:
            greenSlider.value = value
            greenLabel.text = string(from: greenSlider)
        default:
            blueSlider.value = value
            blueLabel.text = string(from: blueSlider)
        }
        changeViewColor()
    }
}

// MARK: - Work with Keyboard
extension RGBViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    private func setupDoneButton(for textField: UITextField) {
        let keyboardView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50)
        )
        let doneButton = UIButton(
            frame: CGRect(x: view.frame.width - 80, y: 0, width: 80, height: 50)
        )
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.systemBlue, for: .normal)
        doneButton.setTitleColor(.gray, for: .highlighted)
        doneButton.addTarget(
            self,
            action: #selector(closeKeyboard),
            for: .touchUpInside
        )
        
        keyboardView.backgroundColor = .systemGray3
        keyboardView.addSubview(doneButton)
        
        textField.inputAccessoryView = keyboardView
    }
    
    @objc private func closeKeyboard() {
        view.endEditing(true)
    }
}
