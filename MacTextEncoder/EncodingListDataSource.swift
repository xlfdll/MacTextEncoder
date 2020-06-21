//
//  EncodingListDataSource.swift
//  MacTextEncoder
//
//  Created by Xlfdll on 2020/06/18.
//  Copyright © 2020 Xlfdll Workstation. All rights reserved.
//

import Cocoa

class EncodingListDataSource: NSObject, NSComboBoxDataSource {
    init(encodingListPointer: UnsafePointer<UInt>) {
        var p = encodingListPointer

        while p.pointee != 0 {
            let cfEncoding = CFStringConvertNSStringEncodingToEncoding(p.pointee)

            self.Encodings.append(cfEncoding)

            p = p.successor()
        }
    }

    var Encodings: [CFStringEncoding] = []

    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        let cfEncoding = self.Encodings[index]
        let encodingName = CFStringGetNameOfEncoding(cfEncoding) ?? "" as CFString
        let encodingIANAName = CFStringConvertEncodingToIANACharSetName(cfEncoding) ?? "" as CFString

        return String(encodingName as NSString) + " (" + String(encodingIANAName as NSString) + ")"
    }

    func comboBox(_ comboBox: NSComboBox, indexOfItemWithStringValue string: String) -> Int {
        let startIndex = string.firstIndex(of: "(") ?? string.startIndex
        let endIndex = string.firstIndex(of: ")") ?? string.endIndex
        let encodingIANAName = String(string[startIndex..<endIndex])
        let cfEncoding = CFStringConvertIANACharSetNameToEncoding(encodingIANAName as CFString)

        return self.Encodings.firstIndex(of: cfEncoding) ?? -1
    }

    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return self.Encodings.count
    }
}
