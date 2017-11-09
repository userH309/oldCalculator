import UIKit
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var outputLbl: UILabel! //create outlet from the counter label
    var btnSound: AVAudioPlayer! //create instance of AVAudioPlayer class
    var currentOperation = Operation.Empty //set empty as default
    var runningNumber = "" //temp input to calculator
    var secondNumb = ""
    var firstNumb = ""
    var result = ""
    enum Operation: String
    { //create enum with operators
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!) //store URL path to sound file in soundURL
        do //check if sound exists
        {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }
        catch let err as NSError //throw error if it doesn't exist
        {
            print(err.debugDescription)
        }
        outputLbl.text = "0" //set label text as 0 when screen loads
    }
    @IBAction func numberPressed(sender: UIButton) //run func when numbers are pressed
    {
        playSound() //call the play sound func
        runningNumber += "\(sender.tag)" //add number tag to runningNumber
        outputLbl.text = runningNumber //set counter label equal to runningNumber
    }
    @IBAction func onDividePressed(sender: AnyObject) //run when divide button is pressed
    {
        currentOperation = Operation.Divide
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) //run when multiply button is pressed
    {
        currentOperation = Operation.Multiply
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject) //run when subtract button is pressed
    {
        currentOperation = Operation.Subtract
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject) //run when add button is pressed
    {
        currentOperation = Operation.Add
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) //run when subtract button is pressed
    {
        processOperation(operation: currentOperation)
    }
    @IBAction func onCePressed(sender: AnyObject)
    {
        currentOperation = Operation.Empty
        runningNumber = ""
        secondNumb = ""
        firstNumb = ""
        result = ""
        outputLbl.text = "0"
    }
    func playSound() //play the button sound
    {
        btnSound.play()
    }
    func processOperation(operation: Operation) //func that pass on Operation enum
    {
        playSound()
        if currentOperation != Operation.Empty //run if not empty
        {
            if runningNumber != "" //run if runningNumber is not empty
            {
                firstNumb = runningNumber //store the runningNumber in
                runningNumber = "" //reset runningNumber
                if currentOperation == Operation.Multiply //run if multiply
                {
                    if secondNumb == ""
                    {
                        result = "\(Double(firstNumb)!)"
                    }
                    else
                    {
                        result = "\(Double(secondNumb)! * Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                }
                else if currentOperation == Operation.Divide //run if divide
                {
                    if secondNumb == ""
                    {
                        result = "\(Double(firstNumb)!)"
                    }
                    else
                    {
                        result = "\(Double(secondNumb)! / Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                    
                }
                else if currentOperation == Operation.Subtract //run if subtract
                {
                    if secondNumb == ""
                    {
                        result = "\(Double(firstNumb)!)"
                    }
                    else
                    {
                        result = "\(Double(secondNumb)! - Double(firstNumb)!)"
                        currentOperation = .Empty
                    }
                }
                else if currentOperation == Operation.Add //run if add
                {
                    if secondNumb == ""
                    {
                        result = "\(Double(firstNumb)!)"
                    }
                    else
                    {
                        result = "\(Double(firstNumb)! + Double(secondNumb)!)"
                        currentOperation = .Empty
                    }
                }
                secondNumb = result //store the result in secondNumb
                outputLbl.text = result //show the result in the label
            }
        }
    }
}

