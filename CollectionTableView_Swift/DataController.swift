//
//  DataController.swift
//  CollectionTableView_Swift
//
//  Created by CC Cooper on 6/27/16.
//  Copyright © 2016 CC Cooper. All rights reserved.
//

import UIKit

enum JsonReadError : ErrorProtocol {
    case unknown, noFileFund, invalidFormat, invalidData
}


class DataController{

    
    func getData() throws -> Dictionary<String,[String]> {
        
        var result:Dictionary<String,[String]> = Dictionary()
        
        guard let path = Bundle.main().pathForResource("Data", ofType: "txt")
            else{
                throw JsonReadError.noFileFund
        }
        
        let fm = FileManager()
        
        if fm.fileExists(atPath: path) == false{
            throw JsonReadError.noFileFund
        }
        
        guard let dataContent = try? Foundation.Data(contentsOf: URL(fileURLWithPath: path))
            else{
                throw JsonReadError.invalidData
        }
        
        guard let arrayOfDictionary = try? JSONSerialization.jsonObject(with: dataContent, options:.mutableContainers) as! Array<Dictionary<String, [String]>>
            else{
                //print("json error: \(error)")
                throw JsonReadError.invalidFormat
        }
        
        print("\(arrayOfDictionary)")
        
        for (index, dictionary) in arrayOfDictionary.enumerated() {
            
            var dicIndex = index
            
            for (key, value) in dictionary{
                dicIndex += 1
                print("index: \(dicIndex)", "Key:\(key)", "Value:\(value)", separator:"\n", terminator:"\n\n")
            }
        }
        if arrayOfDictionary.count > 0 {
            result = arrayOfDictionary[0]
        }



        return result
    }
}
