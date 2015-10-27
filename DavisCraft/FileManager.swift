//
//  FileManager.swift
//  DavisCraft
//
//  Created by Michael Figueroa on 10/26/15.
//  Copyright © 2015 UCDClassNitta. All rights reserved.
//

import Foundation

class FileManager {
    
    class func returnDatFileContents(filename: String, subdirectory: String = "") -> String? {
        let url = returnURLForResource(filename, subdirectory: subdirectory)
            do {
                return try String(contentsOfURL: url!, encoding: NSUTF8StringEncoding)
            }
            catch {
               print("Error retrieving string from: \(filename)")
                return nil
            }
        }
    
        class func returnURLForResource(filename: String, subdirectory: String = "") -> NSURL?
        {
            let url = NSBundle.mainBundle().URLForResource(filename,
                withExtension: nil,
                subdirectory: "data/" + subdirectory)
            guard let newURL = url else {
                print("Could not find file: \(filename)")
                return nil
            }
            
            return newURL
        }

}