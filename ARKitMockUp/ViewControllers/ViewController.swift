//
//  ViewController.swift
//  ARKitMockUp
//
//  Created by Dhiraj Laddha on 22/04/19.
//  Copyright © 2019 Dhiraj Laddha. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SceneKit.ModelIO


class ViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var addItemView: UIView!
    @IBOutlet var addItemCollectionView: UICollectionView!
    @IBOutlet var saveButton : UIBarButtonItem!
    var homeViewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.session.delegate = self
        initialViewSetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the scene session
        sceneView.session.run(configuration)
        sceneView.debugOptions = [.showFeaturePoints]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    //MARK: -- Initial View Set Up --
    func initialViewSetUp() {
        addItemCollectionView.register(UINib(nibName: "AddItemCell", bundle: nil), forCellWithReuseIdentifier: "addItemCell")
        addGestures()
    }
    
    //MARK: -- Add Gestures ..
    func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        tap.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tap)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinched(sender:)))
        sceneView.addGestureRecognizer(pinchGesture)

        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotated(sender:)))
        sceneView.addGestureRecognizer(rotateGesture)

    }
    
    func addFurniture(hitTestResult: ARHitTestResult) {
        let transform = hitTestResult.worldTransform
        let anchor = ARAnchor(name: homeViewModel.furnitureName, transform: transform)
        print("add furniture \(anchor)")
        sceneView.session.add(anchor: anchor)
        self.homeViewModel.furnitureName = ""
    }
    
    func generateNode(furnitureNameString: String, anchor: ARAnchor) -> SCNNode {

        let scene = SCNScene(named: "art.scnassets/\(furnitureNameString).scn")
        var node = SCNNode()
        node = scene!.rootNode
        node.name = furnitureNameString
        
        return node
    }
    
    // MARK: -- Pinch / Zoom Action
    @objc func pinched(sender: UIPinchGestureRecognizer){
        let scnVw = sender.view as! ARSCNView
        let tapLoc = sender.location(in: scnVw)
        
        let hitTest = scnVw.hitTest(tapLoc)
        if !hitTest.isEmpty{
            let node = hitTest.filter({$0.node.name != self.homeViewModel.furnitureName}).first?.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            node?.runAction(pinchAction)
            sender.scale = 1.0
        }
    }
    
    // MARK: -- Rotate / Swipe Action
    @objc func rotated(sender: UIRotationGestureRecognizer){
        let scnVw = sender.view as! ARSCNView
        let tapLoc = sender.location(in: scnVw)
        
        let hitTest = scnVw.hitTest(tapLoc)
        if !hitTest.isEmpty{
            let node = hitTest.filter({$0.node.name != self.homeViewModel.furnitureName}).first?.node
            if sender.state == .began || sender.state == .changed {
                node?.eulerAngles = SCNVector3(CGFloat((node?.eulerAngles.x)!),sender.rotation,CGFloat((node?.eulerAngles.z)!))
            }
        }
    }
    
    //MARK: -- UIAction --
    @IBAction func bottomViewButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0: // add button
            addItemView.isHidden = false
        default:
            break
        }
    }
    
    // MARK: -- Tapped Action
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: self.view)
        let hitTest = sceneView.hitTest(tapLocation, types: .featurePoint)
        if !hitTest.isEmpty {
            print("Touched on the plane\n \(hitTest)")
            // add furniture..
            if self.homeViewModel.furnitureName.isEmpty == true {
                self.showAlert("Please tap on '+' for select new Item.", "")
                return
            }
            addFurniture(hitTestResult: hitTest.first!)// add furniture
        }
        else{
            print("Not a plane")
        }
    }
    
    // MARK: - ARSCNViewDelegate, ARSessionDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard !(anchor is ARPlaneAnchor) else { return }
        let sphereNode = self.generateNode(furnitureNameString: anchor.name!, anchor: anchor)
        print("Did Add Nodes.")
        DispatchQueue.main.async {
            node.addChildNode(sphereNode)
        }
        
    }
    
    /// - Tag: CheckMappingStatus .. ARSession Delegate --
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Enable Save button only when the mapping status is good and an object has been placed
        switch frame.worldMappingStatus {
        case .extending, .mapped:
            saveButton.isEnabled = true
            //saveButton.alpha = 1.0
        default:
            saveButton.isEnabled = false
            //saveButton.alpha = 0.5
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("session \n \(session.currentFrame!)\n")
        print("camera traking state \n \(camera.trackingState)\n")
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        self.showAlert("\(error.localizedDescription)", "")
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

//MARK: -- UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addItemCell", for: indexPath) as! AddItemCell
        let imageName = homeViewModel.items[indexPath.row]
        cell.configureData(imgName: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.addItemView.isHidden = true
        self.homeViewModel.furnitureName = homeViewModel.items[indexPath.row]
    }
    
}
