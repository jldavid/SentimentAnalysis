import Foundation
import SwiftUI
import CoreML
import NaturalLanguage

class SentimentIdentifier : ObservableObject {
    
    @Published var prediction = ""
    @Published var confidence = 0.0
    
    var model  = MLModel()
    var sentimentPredictor  = NLModel()
    
    init(){
        do {
            let config = MLModelConfiguration()
            let sentiment_model = try Sentiment(configuration: config).model
            self.model = sentiment_model
        } catch { 
            print(error)
        }
        do {
            let predictor = try NLModel(mlModel: model)
            self.sentimentPredictor = predictor
        } catch {
            print(error)
        }
    }

    func predict(_ text: String){
        self.prediction = sentimentPredictor.predictedLabel(for: text) ?? ""
        let predictionSet = sentimentPredictor.predictedLabelHypotheses(for: text, maximumCount: 1)
        self.confidence = predictionSet[prediction] ?? 0.0
    }
}
