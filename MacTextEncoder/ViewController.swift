//
//  ViewController.swift
//  MacTextEncoder
//
//  Created by Xlfdll on 2020/06/18.
//  Copyright © 2020 Xlfdll Workstation. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDelegate, NSTextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SourceTextField.delegate = self
        SourceEncodingComboBox.dataSource = self.sourceEncodingDataSource
        SourceEncodingComboBox.selectItem(at: self.sourceEncodingDataSource.Encodings.firstIndex(of: CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) ?? 0)
        SourceEncodingComboBox.delegate = self
        TargetEncodingComboBox.dataSource = self.targetEncodingDataSource
        TargetEncodingComboBox.selectItem(at: self.targetEncodingDataSource.Encodings.firstIndex(of: CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) ?? 0)
        TargetEncodingComboBox.delegate = self

        updateButtonStates()
    }

    @IBAction func SourceEncodingUpPushButtonAction(_ sender: NSButton) {
        if (SourceEncodingComboBox.indexOfSelectedItem > 0) {
            SourceEncodingComboBox.selectItem(at: SourceEncodingComboBox.indexOfSelectedItem - 1)
        }

        updateButtonStates()
    }

    @IBAction func SourceEncodingDownPushButtonAction(_ sender: NSButton) {
        SourceEncodingComboBox.selectItem(at: SourceEncodingComboBox.indexOfSelectedItem + 1)

        updateButtonStates()
    }

    @IBAction func TargetEncodingUpPushButtonAction(_ sender: NSButton) {
        TargetEncodingComboBox.selectItem(at: TargetEncodingComboBox.indexOfSelectedItem - 1)

        updateButtonStates()
    }

    @IBAction func TargetEncodingDownPushButtonAction(_ sender: NSButton) {
        TargetEncodingComboBox.selectItem(at: TargetEncodingComboBox.indexOfSelectedItem + 1)

        updateButtonStates()
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        updateButtonStates()
        performTextConversion()
    }

    func controlTextDidChange(_ notification: Notification) {
        performTextConversion()
    }

    private func performTextConversion() {
        if (SourceTextField.stringValue != "") {
            let sourceEncoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(self.sourceEncodingDataSource.Encodings[SourceEncodingComboBox.indexOfSelectedItem]))
            let targetEncoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(self.targetEncodingDataSource.Encodings[TargetEncodingComboBox.indexOfSelectedItem]))
            // Get bytes using source encoding
            let sourceTextData = SourceTextField.stringValue.data(using: sourceEncoding, allowLossyConversion: true)!

            // Convert!
            ResultTextField.stringValue = String(data: sourceTextData, encoding: targetEncoding) ?? " "
        } else {
            ResultTextField.stringValue = "";
        }
    }

    private func updateButtonStates() {
        SourceEncodingUpPushButton.isEnabled = SourceEncodingComboBox.indexOfSelectedItem > 0;
        SourceEncodingDownPushButton.isEnabled = SourceEncodingComboBox.indexOfSelectedItem < self.sourceEncodingDataSource.Encodings.count;
        TargetEncodingUpPushButton.isEnabled = TargetEncodingComboBox.indexOfSelectedItem > 0;
        TargetEncodingDownPushButton.isEnabled = TargetEncodingComboBox.indexOfSelectedItem < self.targetEncodingDataSource.Encodings.count;
    }

    let sourceEncodingDataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)
    let targetEncodingDataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)

    @IBOutlet weak var SourceEncodingComboBox: NSComboBox!
    @IBOutlet weak var SourceEncodingUpPushButton: NSButton!
    @IBOutlet weak var SourceEncodingDownPushButton: NSButton!
    @IBOutlet weak var SourceTextField: NSTextField!
    @IBOutlet weak var TargetEncodingComboBox: NSComboBox!
    @IBOutlet weak var TargetEncodingUpPushButton: NSButton!
    @IBOutlet weak var TargetEncodingDownPushButton: NSButton!
    @IBOutlet weak var ResultTextField: NSTextField!
}

