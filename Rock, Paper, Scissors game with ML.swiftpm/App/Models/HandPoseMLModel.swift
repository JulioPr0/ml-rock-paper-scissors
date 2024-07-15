import Foundation
import CoreML

/*#-code-walkthrough(ml.model)*/
final class HandPoseMLModel: NSObject, Identifiable {
/*#-code-walkthrough(ml.model)*/
    let name: String
    let mlModel: MLModel
    let url: URL
    
    private var classLabels: [Any] {
        mlModel.modelDescription.classLabels ?? []
    }

    init(name: String, mlModel: MLModel, url: URL) {
        self.name = name
        self.mlModel = mlModel
        self.url = url
    }

    /*#-code-walkthrough(ml.prediction)*/
    func predict(poses: HandPoseInput) throws -> HandPoseOutput? {
        let features = try mlModel.prediction(from: poses)
        let output = HandPoseOutput(features: features)
        return output
    }
    /*#-code-walkthrough(ml.prediction)*/
}

/*#-code-walkthrough(ml.input)*/
class HandPoseInput {
/*#-code-walkthrough(ml.input)*/
    var poses: MLMultiArray
    
    init(poses: MLMultiArray) {
        self.poses = poses
    }
}

/*#-code-walkthrough(ml.output)*/
class HandPoseOutput {
/*#-code-walkthrough(ml.output)*/
    let provider : MLFeatureProvider

    lazy var labelProbabilities: [String : Double] = { [unowned self] in
        self.getOutputProbabilities()
    }()

    lazy var label: String = { [unowned self] in
        self.getOutputLabel()
    }()

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}
