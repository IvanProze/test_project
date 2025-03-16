import Foundation
import AVFoundation
import SwifterSwift

final class AudioRecorderManager {
    static let shared = AudioRecorderManager()
    private var audioRecorder: AVAudioRecorder?
    private var fileName: String = ""
    
    func prepareSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true)
    }
    
    func startRecording() {
        fileName = String.random(ofLength: 50) + ".m4a"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileURL = documentsDirectory.appendingPathComponent(fileName)
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: settings)
        audioRecorder?.record()
    }
    
    @discardableResult
    func stopRecording() -> String {
        audioRecorder?.stop()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fullPath = documentsDirectory.appendingPathComponent(fileName).path
        print("Audio save path: ", fullPath)
        return fileName
    }
    
    func isRecordingInProgress() -> Bool {
        return audioRecorder?.isRecording ?? false
    }
    
    func checkMicrophonePermission(completion: @escaping (Bool) -> Void) {
        let permission = AVAudioSession.sharedInstance().recordPermission
        switch permission {
        case .granted:
            completion(true)
        case .denied:
            NavigationService.shared.presentMicrophoneSettingsAlert()
            completion(false)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        NavigationService.shared.presentMicrophoneSettingsAlert()
                        completion(false)
                    }
                }
            }
        @unknown default:
            completion(false)
        }
    }

}
