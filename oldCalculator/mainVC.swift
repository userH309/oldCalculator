import UIKit
import AVFoundation

class mainVC: UIViewController {
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var secondNumb = ""
    var firstNumb = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        //Store the path for our button sound.
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        //Set a default user value.
        outputLbl.text = "0"
    }
    
    func processOperation(operation: Operation) {
        //Play sound when user tap on button.
        btnSound.play()
        //Check if user has tapped an operation.
        if currentOperation != Operation.Empty {
            //Check if user has entered a number.
            if runningNumber != "" {
                firstNumb = runningNumber
                runningNumber = ""
                //Switch between operation based on process button tapped.
                if currentOperation == Operation.Multiply {
                    if secondNumb == "" {
                        result = "\(Double(firstNumb)!)"
                    }
                    else {
                        result = "\(Double(secondNumb)! * Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                }
                else if currentOperation == Operation.Divide {
                    if secondNumb == "" {
                        result = "\(Double(firstNumb)!)"
                    }
                    else {
                        result = "\(Double(secondNumb)! / Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                }
                else if currentOperation == Operation.Subtract {
                    if secondNumb == "" {
                        result = "\(Double(firstNumb)!)"
                    }
                    else {
                        result = "\(Double(secondNumb)! - Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                }
                else if currentOperation == Operation.Add {
                    if secondNumb == "" {
                        result = "\(Double(firstNumb)!)"
                    }
                    else {
                        result = "\(Double(firstNumb)! + Double(secondNumb)!)"
                        currentOperation = .Empty
                    }
                }
                secondNumb = result
                outputLbl.text = result
            }
        }
    }
    
    //Run when numbers are pressed.
    @IBAction func numberPressed(sender: UIButton) {
        btnSound.play()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    //Run when divide button is pressed.
    @IBAction func onDividePressed(sender: AnyObject) {
        currentOperation = Operation.Divide
        processOperation(operation: .Divide)
    }
    //Run when multiply button is pressed.
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        currentOperation = Operation.Multiply
        processOperation(operation: .Multiply)
    }
    //Run when subtract button is pressed.
    @IBAction func onSubtractPressed(sender: AnyObject){
        currentOperation = Operation.Subtract
        processOperation(operation: .Subtract)
    }
    //Run when add button is pressed.
    @IBAction func onAddPressed(sender: AnyObject) {
        currentOperation = Operation.Add
        processOperation(operation: .Add)
    }
    //Run when subtract button is pressed.
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    //Clear the screen on CE press.
    @IBAction func onCePressed(sender: AnyObject) {
        currentOperation = Operation.Empty
        runningNumber = ""
        secondNumb = ""
        firstNumb = ""
        result = ""
        outputLbl.text = "0"
    }
}

