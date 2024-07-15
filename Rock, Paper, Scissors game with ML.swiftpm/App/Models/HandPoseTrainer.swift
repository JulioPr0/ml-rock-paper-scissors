import Foundation
/*#-code-walkthrough(ml.frameworks)*/
import CreateML
import CoreML
/*#-code-walkthrough(ml.frameworks)*/

final class HandPoseTrainer {
    /*#-code-walkthrough(imageAugment.options)*/
    private var augmentationParameters = MLHandPoseClassifier.ImageAugmentationOptions()
    /*#-code-walkthrough(imageAugment.options)*/

    /*#-code-walkthrough(ml.classifier)*/
    var classifier: MLHandPoseClassifier?
    /*#-code-walkthrough(ml.classifier)*/

    var session: TrainingSession?
        
   /*#-code-walkthrough(ml.training)*/ func train(with dataModel: TrainerDataModel) /*#-code-walkthrough(ml.training)*/async throws {
        guard let trainingDataset = dataModel.currentTrainingDataset?.directory else { return }
        var modelParameters = MLHandPoseClassifier.ModelParameters()

        if let validationDataset = dataModel.currentValidationDataset?.directory {
            modelParameters.validation = .dataSource(.labeledDirectories(at: validationDataset)) 
        } else {
            modelParameters.validation = .none
        }

        //#-learning-code-snippet(imageAugment.code)
        modelParameters.augmentationOptions = augmentationParameters

        let trainingDataSource = MLHandPoseClassifier.DataSource.labeledDirectories(at: trainingDataset)
        try await runTrainingSession(with: trainingDataSource, dataModel: dataModel, modelParameters: modelParameters)
    }
}
