//
//  SwiftUIView.swift
//  GPS
//
//  Created by Johnne Lemand on 10/05/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
                print("Tu dispositivo no es aplicable para el procesamiento de video")
                return
        }
            let videoInput : AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput (device: videoCaptureDevice)
            }catch{
                print("Tu dispositivo no puede dar entrada de video")
                return
            }
            if (self.captureSession.canAddInput(videoInput)){
                self.captureSession.addInput(videoInput)
            } else {
                print("Tu dispositivo no puede dar entrada en la sesión de captura")
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (self.captureSession.canAddOutput(metadataOutput)) {
                self.captureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
                
            } else{
                return
            }
            
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            self.previewLayer.frame = self.view.layer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(self.previewLayer)
            print("Running")
            self.captureSession.startRunning()
        
        })
    
    }
    
}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        if let first = metadataObjects.first{
            guard let readableObject = first as? AVMetadataMachineReadableCodeObject else {
                return
            }
            guard let stringValue = readableObject.stringValue else{
                return
            }
            found(code: stringValue)
        }else{
            print("No puede leer el código, intente nuevamente o mantenga su dispositivo en el código de escáner qr ó de código de barras")
        }
    }
    
    func found(code: String)  {
        print(code)
    }
}
