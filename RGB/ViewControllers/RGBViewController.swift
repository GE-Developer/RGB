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
    @IBOutlet private var labels: [UILabel]!
    @IBOutlet private var sliders: [UISlider]!
    @IBOutlet private var textFields: [UITextField]!
    
    // MARK: - Public Properties
    var mainColor: UIColor!
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let colors = mainColor.cgColor.components ?? []
        
        for (slider, color) in zip(sliders, colors) {
            slider.value = Float(color)
            updateUI(with: slider)
        }
        changeViewColor()
    }
    
    // MARK: - IBAction Methods
    @IBAction func sliderAction(_ sender: UISlider) {
        changeViewColor()
        updateUI(with: sender)
    }
    
    // MARK: - Private Methods
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func changeViewColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(sliders[0].value),
            green: CGFloat(sliders[1].value),
            blue: CGFloat(sliders[2].value),
            alpha: 1
        )
    }
    
    private func updateUI(with sender: UISlider) {
        labels[sender.tag].text = string(from: sender)
        textFields[sender.tag].text = string(from: sender)
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
        
        sliders[textField.tag].setValue(value, animated: true)
        labels[textField.tag].text = string(from: sliders[textField.tag])
        
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
