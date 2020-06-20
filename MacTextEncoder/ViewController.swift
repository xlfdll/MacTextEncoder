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
        SourceEncodingComboBox.selectItem(at: self.sourceEncodingDataSource.Encodings.firstIndex(of: String.Encoding.utf8.rawValue) ?? 0)
        SourceEncodingComboBox.delegate = self
        TargetEncodingComboBox.dataSource = self.targetEncodingDataSource
        TargetEncodingComboBox.selectItem(at: self.targetEncodingDataSource.Encodings.firstIndex(of: String.Encoding.utf8.rawValue) ?? 0)
        TargetEncodingComboBox.delegate = self
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

    func comboBoxSelectionDidChange(_ notification: Notification) {
        performTextConversion()
    }

    func controlTextDidChange(_ notification: Notification) {
        performTextConversion()
    }

    private func performTextConversion() {
        let sourceEncoding = String.Encoding(rawValue: self.sourceEncodingDataSource.Encodings[SourceEncodingComboBox.indexOfSelectedItem])
        let targetEncoding = String.Encoding(rawValue: self.targetEncodingDataSource.Encodings[TargetEncodingComboBox.indexOfSelectedItem])
        // Get unconverted bytes using Swift's internal encoding (currently UTF-8)
        // (Can print individual bytes using indexer)
        // Refer to https://swift.org/blog/utf8-string/
        let sourceTextData = SourceTextField.stringValue.data(using: sourceEncoding, allowLossyConversion: true)!

        ResultTextField.stringValue = String(data: sourceTextData, encoding: targetEncoding) ?? " "
    }

    let sourceEncodingDataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)
    let targetEncodingDataSource = EncodingListDataSource(encodingListPointer: NSString.availableStringEncodings)

    @IBOutlet weak var SourceEncodingComboBox: NSComboBox!
    @IBOutlet weak var SourceTextField: NSTextField!
    @IBOutlet weak var TargetEncodingComboBox: NSComboBox!
    @IBOutlet weak var ResultTextField: NSTextField!
}

