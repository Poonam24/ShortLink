//
//  StorageManager.swift
//  ApollonAssignment
//
//  Created by Poonam on 13/08/21.
//

import Foundation

class StorageManager {

    
    func loadData() -> [ResponseResult] {
        var fetchedResponseData : [ResponseResult] = []
        let filename = getDocumentsDiretory().appendingPathComponent("LinkHistory")

        do {
            let data = try Data(contentsOf: filename)
            fetchedResponseData = try JSONDecoder().decode([ResponseResult].self, from: data)
        } catch let error{
            print("Failed \(error.localizedDescription)")
        }
        
        return fetchedResponseData;
    }

    func saveData(dataToBeSaved : [ResponseResult]) {
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("LinkHistory")
            let data = try JSONEncoder().encode(dataToBeSaved)
            // check if file exist if yes go to end of file and write
            // else create file with this data
            if(FileManager.default.fileExists(atPath: filename.path)){
                let fileHandle = try FileHandle(forWritingTo: filename)
                fileHandle.seekToEndOfFile()
                try data.write(to: filename)
                fileHandle.closeFile();
            } else {
                try data.write(to: filename)
            }
        } catch let error{
            print("Failed \(error.localizedDescription)")
        }
    }
    
    
    
    func removeLinkAtIndex(index : Int) {
        var updatedData : [ResponseResult] = loadData()
        _ = updatedData.remove(at: index);

        // UpdateData after removing the particular entry
        do {
            let filename = getDocumentsDiretory().appendingPathComponent("LinkHistory")
            if(FileManager.default.fileExists(atPath: filename.path)){
                let data = try? JSONEncoder().encode(updatedData)
                try? data?.write(to: filename);
            }
        } catch {
            print("Unable to save profile data")
        }
    }

    func getDocumentsDiretory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
