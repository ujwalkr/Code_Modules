//
//  ScannerManager.swift
//  MOH
//
//  Created by Ujwal K Raikar on 01/08/19.
//

import AVFoundation
import UIKit

class ScannerManager: NSObject {
    
    private var viewController: UIViewController
    private var captureSession: AVCaptureSession?
    private var scanOutputHandler: (_ code: String) -> Void
    
    init(withViewController viewController: UIViewController, view: UIView, handler: @escaping (String) -> Void) {
        self.viewController = viewController
        self.scanOutputHandler = handler
        
        super.init()
        
        if let captureSession = self.createCaptureSession() {
            self.captureSession = captureSession
            let previewLayer = self.createPreviewLayer(withCaptureSession: captureSession, view: view)
            view.layer.addSublayer(previewLayer)
        }
    }
    
    private func createCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return nil
        }
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            let metaDataOutput = AVCaptureMetadataOutput()
            
            if captureSession.canAddInput(deviceInput) {
                captureSession.addInput(deviceInput)
            }else {
                return nil
            }
            
            if captureSession.canAddOutput(metaDataOutput) {
                captureSession.addOutput(metaDataOutput)
                if let viewController = self.viewController as? AVCaptureMetadataOutputObjectsDelegate {
                    metaDataOutput.setMetadataObjectsDelegate(viewController, queue: DispatchQueue.main)
                    metaDataOutput.metadataObjectTypes = self.metaDataTypes()
                }
            }else {
                return nil
            }
            
        }catch {
            return nil
        }
        return captureSession
    }
    
    private func metaDataTypes() -> [AVMetadataObject.ObjectType] {
        return [.qr,.code128,.code39,.code93,.code39Mod43,.ean8,.ean13,.interleaved2of5,.itf14,.pdf417]
    }
    
    private func createPreviewLayer(withCaptureSession captureSession: AVCaptureSession,
                                    view: UIView) -> AVCaptureVideoPreviewLayer {
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.bounds = view.layer.bounds
        previewLayer.frame = view.layer.frame
        previewLayer.videoGravity = .resizeAspectFill
    
        return previewLayer
    }
    
    func scannerDelegate(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject],
                         from connection: AVCaptureConnection) {
        self.requestCaptureSessionStopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else{
                return
            }
            
            guard let strignValue = readableObject.stringValue else {
                return
            }
            
            self.scanOutputHandler(strignValue)
        }
    }
    
    func requestCaptureSessionStartRunning() {
        guard let captureSession = self.captureSession else {
            return
        }
        
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func requestCaptureSessionStopRunning() {
        guard let captureSession = self.captureSession else {
            return
        }
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}
