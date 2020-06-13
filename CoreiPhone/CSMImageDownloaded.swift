//
//  CSMImageDownloaded.swift
//  CoreSoleraMobile
//
//  Created by Kenyi Rodriguez on 15/03/18.
//

import UIKit

let CSMImageDownloadedDirectorioDescarga = "Caches"

extension UIImageView{
    
    fileprivate func saveImage(_ image : UIImage?, withName name : String, inDirectory directory : String?) -> Bool {
        
        if image == nil {return false}
        
        let documentsPath   = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        let cachesPath      = documentsPath.appending("/" + (directory ?? CSMImageDownloadedDirectorioDescarga))
        let filePath        = cachesPath.appending("/" + name)
        let data            = name.hasSuffix("jpg") == true ? image!.jpegData(compressionQuality: 1.0) : image!.pngData()
        
        do{
            try data?.write(to: URL.init(fileURLWithPath: filePath), options: Data.WritingOptions.atomic)
            print("CSMImageDownloaded / Se guardó la imagen \(name)")
            return true
        }catch{
            print("CSMImageDownloaded / NO se guardó la imagen \(name)")
            return false
        }
    }
    
    fileprivate func getImageWithName(_ name : String, inDirectory directory : String?) -> UIImage? {
        
        var image : UIImage?
        
        let fileManager     = FileManager.default
        let documentsPath   = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        let cachesPath      = documentsPath.appending("/" + (directory ?? CSMImageDownloadedDirectorioDescarga))
        let filePath        = cachesPath.appending("/" + name)
        
        if fileManager.fileExists(atPath: filePath){
            image = UIImage(contentsOfFile: filePath)
        }
        
        return image
    }
    
    fileprivate func downloadImageWithUrl(_ url : String, withName name : String) -> UIImage?{
        
        let newUrl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        if let urlDownload = URL(string: newUrl){
            do{
                let dataImageDownloaded = try Data(contentsOf: urlDownload)
                let imgDownloaded = UIImage(data: dataImageDownloaded)
                return self.saveImage(imgDownloaded, withName: name, inDirectory: nil) == true ? self.getImageWithName(name, inDirectory: nil) : nil
            }catch{
                print("CSMImageDownloaded error al descargar: \(url)")
                return nil
            }
        }else{
            print("CSMImageDownloaded error al descargar: \(url)")
            return nil
        }
    }
    
    public func downloadImagenInUrl(_ url : String, withPlaceHolderImage imgPlaceHolder : UIImage?, onSuccess success : @escaping(_ urlFile : String, _ image : UIImage?) -> Void) {
        
        self.image = imgPlaceHolder
    
        var name = NSString(string: url).replacingOccurrences(of: "/", with: "")
        name = name.hasSuffix("jpg") == true ? name.replacingOccurrences(of: ".jpg", with: "@2x.jpg") : name.replacingOccurrences(of: ".png", with: "@2x.png")
        
        DispatchQueue.global(qos: .default).async {
            
            var imageSaved = self.getImageWithName(name, inDirectory: nil)
            
            if imageSaved == nil{
                imageSaved = self.downloadImageWithUrl(url, withName: name)
                DispatchQueue.main.async {
                    success(url, imageSaved != nil ? imageSaved : imgPlaceHolder)
                }
            }else{
                DispatchQueue.main.async {
                    success(url, imageSaved!)
                }
            }
        }
    }
}


