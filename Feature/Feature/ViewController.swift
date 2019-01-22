//
//  ViewController.swift
//  Feature
//
//  Created by Linh Pham on 1/22/19.
//  Copyright © 2019 NTUC. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

open class ViewController: UIViewController {

	var cameraImageView: UIImageView!
	
	lazy var vision = Vision.vision()
	var barcodeDetector: VisionBarcodeDetector?
	let captureSession = AVCaptureSession()
	var previewLayer: AVCaptureVideoPreviewLayer?
	
	override open func viewDidLoad() {
        super.viewDidLoad()
		
//		FirebaseApp.configure()

		let format = VisionBarcodeFormat.qrCode
		let barcodeOptions = VisionBarcodeDetectorOptions(formats: format)
		barcodeDetector = vision.barcodeDetector(options: barcodeOptions)
		
		cameraImageView = UIImageView(frame: UIScreen.main.bounds)
    }
	
	open override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		captureSession.sessionPreset = AVCaptureSession.Preset.photo
		guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video),
			let deviceInput = try? AVCaptureDeviceInput(device: captureDevice)
			else { return }
		let deviceOutput = AVCaptureVideoDataOutput()
		deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
		deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
		captureSession.addInput(deviceInput)
		self.captureSession.commitConfiguration()
		
		captureSession.addOutput(deviceOutput)
		self.captureSession.commitConfiguration()
		
		self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		
		guard let preview = self.previewLayer else{
			return
		}
		preview.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
		
		preview.frame = cameraImageView.frame
		preview.videoGravity = .resizeAspectFill
		cameraImageView.layer.insertSublayer(preview, at: 0)//(preview)
		
		captureSession.startRunning()
	}
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
	
	public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		
		if let barcodeDetector = self.barcodeDetector {
			
			let visionImage = VisionImage(buffer: sampleBuffer)
			
			barcodeDetector.detect(in: visionImage) { [weak self] (barcodes, error) in
				
				if let error = error {
					debugPrint(error.localizedDescription)
					return
				}
				
				for barcode in barcodes! {
					debugPrint(barcode.rawValue!)
				}
			}
		}
	}
}
