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
        SourceEncodingComboBox.dataSource = self.dataSource
        SourceEncodingComboBox.selectItem(at: self.dataSource.Encodings.firstIndex(of: String.Encoding.utf8.rawValue) ?? 0)
        SourceEncodingComboBox.delegate = self
        SourceTextField.delegate = self
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        performTextConversion()
    }

    func controlTextDidEndEditing(_ obj: Notification) {
        performTextConversion()
    }

    private func performTextConversion() {
        let encoding = String.Encoding(rawValue: self.dataSource.Encodings[SourceEncodingComboBox.indexOfSelectedItem])

        if let data = SourceTextField.stringValue.data(using: encoding, allowLossyConversion: true) {
            ResultTextField.stringValue = String(decoding: data, as: UTF8.self)
        }
    }

    let dataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)

    @IBOutlet weak var SourceEncodingComboBox: NSComboBox!
    @IBOutlet weak var SourceTextField: NSTextField!
    @IBOutlet weak var ResultTextField: NSTextField!
}

