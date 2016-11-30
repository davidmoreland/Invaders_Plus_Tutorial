/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
 var pause = false
 var SettingVC : SettingsViewController = SettingsViewController()
  var gameScene : GameScene = GameScene()
  
 
  @IBAction func SettingsButton(_ sender: UIButton) {
    self.performSegue(withIdentifier: "presentSettings", sender: self)
    
   
    
  }
  
  // let scene = GameScene(size: skView.frame.size)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure the view.
    let skView = self.view as! SKView
    skView.showsFPS = true
    skView.showsNodeCount = true
    
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = true
    
    // Create and configure the scene.
  let scene = GameScene(size: skView.frame.size)
    self.gameScene = scene
    
    skView.presentScene(scene)
    
    // Pause the view (and thus the game) when the app is interrupted or backgrounded
    NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.handleApplicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.handleApplicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.portrait
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  func handleApplicationWillResignActive (_ note: Notification) {
    let skView = self.view as! SKView
    skView.isPaused = true
  }
  
  func handleApplicationDidBecomeActive (_ note: Notification) {
    let skView = self.view as! SKView
    skView.isPaused = false
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "presentSettings" {
      self.SettingVC  = segue.destination as! SettingsViewController
     // SettingVC.pause = true
      gameScene.pause = true
      SettingVC.gameScene = self.gameScene
    //  SettingVC.restoreSettings()
    
     // settingsVC.pauseGame(pause: true)
     
    }
  }

}


