//
//  ViewController.swift
//  Videos
//
//  Created by Zhanna Fursova on 12/5/14.
//  Copyright (c) 2014 John Doe. All rights reserved.
//


import UIKit;
import MediaPlayer;	//for MPMoviePlayerController
import AVFoundation;

class ViewController: UIViewController {
	let moviePlayerController: MPMoviePlayerController = MPMoviePlayerController();
	let moviePlayerController2: MPMoviePlayerController = MPMoviePlayerController();
	let moviePlayerController3: MPMoviePlayerController = MPMoviePlayerController();
	let player: AVAudioPlayer?;
	var save: UIView?;	//Save the big white View while the movie is on screen.

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);

		// Bundles
		
		let bundle0: NSBundle = NSBundle.mainBundle();

		let bundle: NSBundle? = NSBundle.mainBundle();
		if bundle == nil {
			println("Could not access main bundle.");
			return;
		}
		println("bundle.bundlePath = \(bundle!.bundlePath)\n");
		
		let bundle2: NSBundle? = NSBundle.mainBundle();
		if bundle2 == nil {
			println("Could not access main bundle.");
			return;
		}
		println("bundle.bundlePath = \(bundle2!.bundlePath)\n");
		
		let bundle3: NSBundle? = NSBundle.mainBundle();
		if bundle3 == nil {
			println("Could not access main bundle.");
			return;
		}
		println("bundle.bundlePath = \(bundle3!.bundlePath)\n");
		
		//Filenames
		
		var path: String? = bundle0.pathForResource("alien", ofType: "mp3");
		if path == nil {
			println("could not find path to file alien.mp3");
			return;
		}
		println("path = \(path!)\n");

		let filename: String? = bundle!.pathForResource("1", ofType: "m4v");
		if filename == nil {
			println("could not find file 1.m4v");
			return;
		}
		println("filename = \(filename!)\n");
		
		let filename2: String? = bundle2!.pathForResource("2", ofType: "m4v");
		if filename2 == nil {
			println("could not find file 2.m4v");
			return;
		}
		println("filename = \(filename2!)\n");
		
		let filename3: String? = bundle2!.pathForResource("3", ofType: "m4v");
		if filename3 == nil {
			println("could not find file 3.m4v");
			return;
		}
		println("filename = \(filename3!)\n");

	
		
		// URLs
		
		let url0: NSURL? = NSURL(fileURLWithPath: path!, isDirectory: false);
		if url0 == nil {
			println("could not create URL");
			return;
		}
		println("url = \(url0!)\n");

		let url: NSURL? = NSURL(fileURLWithPath: filename!);
		if url == nil {
			println("could not create URL for file \(filename)");
			return;
		}
		println("url = \(url!)\n");
		
		let url2: NSURL? = NSURL(fileURLWithPath: filename2!);
		if url2 == nil {
			println("could not create URL for file \(filename2)");
			return;
		}
		println("url = \(url2!)\n");
		
		let url3: NSURL? = NSURL(fileURLWithPath: filename3!);
		if url3 == nil {
			println("could not create URL for file \(filename3)");
			return;
		}
		println("url = \(url3!)\n");

		// Players
		
		var error: NSError?
		player = AVAudioPlayer(contentsOfURL: url0!, error: &error);
		if player == nil {
			println("could not create AVAudioPlayer: \(error!)\n");
			return;
		}
		
		player!.volume = 1.0;		//the default
		player!.numberOfLoops = -1;	//negative for infinite loop
		player!.pan = 0.0;			//-1.0 is left, +1.0 is right
		println("player!.numberOfChannels = \(player!.numberOfChannels)"); //mono or stereo

		if !player!.prepareToPlay() {	//means if player!.prepareToPlay() == false {
			println("player!.prepareToPlay failed");
		}


		moviePlayerController = MPMoviePlayerController(contentURL: url!);
		println("moviePlayerController.contentURL = \(moviePlayerController.contentURL)\n");

		moviePlayerController.shouldAutoplay = false;	//don't start spontaneously
		moviePlayerController.scalingMode = MPMovieScalingMode.None;
		moviePlayerController.controlStyle = MPMovieControlStyle.Fullscreen;
		moviePlayerController.movieSourceType = MPMovieSourceType.File; //vs. stream
	
		
		moviePlayerController2 = MPMoviePlayerController(contentURL: url2!);
		println("moviePlayerController.contentURL = \(moviePlayerController2.contentURL)\n");

		moviePlayerController2.shouldAutoplay = false;	//don't start spontaneously
		moviePlayerController2.scalingMode = MPMovieScalingMode.None;
		moviePlayerController2.controlStyle = MPMovieControlStyle.Fullscreen;
		moviePlayerController2.movieSourceType = MPMovieSourceType.File; //vs. stream
		
		moviePlayerController3 = MPMoviePlayerController(contentURL: url3!);
		println("moviePlayerController.contentURL = \(moviePlayerController3.contentURL)\n");

		moviePlayerController3.shouldAutoplay = false;	//don't start spontaneously
		moviePlayerController3.scalingMode = MPMovieScalingMode.None;
		moviePlayerController3.controlStyle = MPMovieControlStyle.Fullscreen;
		moviePlayerController3.movieSourceType = MPMovieSourceType.File; //vs. stream
		

		let center: NSNotificationCenter = NSNotificationCenter.defaultCenter();

		center.addObserver(self,
			selector: "playbackDidFinish:",
			name: MPMoviePlayerPlaybackDidFinishNotification,
			object: moviePlayerController);
		
		let center2: NSNotificationCenter = NSNotificationCenter.defaultCenter();
		
		center2.addObserver(self,
			selector: "playbackDidFinish2:",
			name: MPMoviePlayerPlaybackDidFinishNotification,
			object: moviePlayerController2);
		
		let center3: NSNotificationCenter = NSNotificationCenter.defaultCenter();
		
		center3.addObserver(self,
			selector: "playbackDidFinish3:",
			name: MPMoviePlayerPlaybackDidFinishNotification,
			object: moviePlayerController3);

	}

	override func loadView() {
		//Implant a reference to this view controller into the newborn View.
		view = View(viewController: self);
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	
	func valueChanged(mySwitch: UISwitch!) {
	
		if player == nil {
			return;
		}

		if mySwitch.on {
			//The switch has just been turned on.
			if !player!.play() {
				println("player!.play failed.");
			}
			println("Playing at \(player!.currentTime) of \(player!.duration) seconds.");
		} else {
			//The switch has just been turned off.
			player!.pause();
			println("Paused at \(player!.currentTime) of \(player!.duration) seconds.");
			//Don't need to prepareToPlay again after a pause.
		}
	}

	//Called when the user presses the button in the View.

	func touchUpInside(button: UIButton!) {
	
		player!.pause();
		
		var title: String? = button.titleForState(UIControlState.Normal);
		if title == nil {
			title = "untitled";
		}
		println("touchUpInside title = \(title!)");

		//Make sure the moviePlayerController's view is the same size
		//as the View it's about to replace.
		moviePlayerController.view.frame = view.frame;

		//Remove the big white View from the window, but save it.
		//(The window is the superview of the big white View.)
		save = view;
		let superview: UIView = view.superview!;
		view.removeFromSuperview();

		//Put the moviePlayerController's view into the window.
		superview.addSubview(moviePlayerController.view);
		moviePlayerController.prepareToPlay();
		moviePlayerController.play();
	}
	
	func touchUpInside2(button2: UIButton!) {
	
		player!.pause();
		
		var title: String? = button2.titleForState(UIControlState.Normal);
		if title == nil {
			title = "untitled";
		}
		println("touchUpInside title = \(title!)");

		//Make sure the moviePlayerController's view is the same size
		//as the View it's about to replace.
		moviePlayerController2.view.frame = view.frame;

		//Remove the big white View from the window, but save it.
		//(The window is the superview of the big white View.)
		save = view;
		let superview2: UIView = view.superview!;
		view.removeFromSuperview();

		//Put the moviePlayerController's view into the window.
		superview2.addSubview(moviePlayerController2.view);
		moviePlayerController2.prepareToPlay();
		moviePlayerController2.play();
	}


	func touchUpInside3(button3: UIButton!) {
	
		player!.pause();
		
		var title: String? = button3.titleForState(UIControlState.Normal);
		if title == nil {
			title = "untitled";
		}
		println("touchUpInside title = \(title!)");

		//Make sure the moviePlayerController's view is the same size
		//as the View it's about to replace.
		moviePlayerController3.view.frame = view.frame;

		//Remove the big white View from the window, but save it.
		//(The window is the superview of the big white View.)
		save = view;
		let superview3: UIView = view.superview!;
		view.removeFromSuperview();

		//Put the moviePlayerController's view into the window.
		superview3.addSubview(moviePlayerController3.view);
		moviePlayerController3.prepareToPlay();
		moviePlayerController3.play();
	}

	//Called when the playback finishes.

	func playbackDidFinish(notification: NSNotification) {
		//Print the two relevant items in the userInfo dictinary.
		if notification.userInfo != nil {
			let userInfo:[NSObject: AnyObject] = notification.userInfo!;
			let i: Int? = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as? Int;
			if i != nil && i! != MPMovieFinishReason.PlaybackEnded.rawValue {
				println("playbackDidFinish: reason = \(i!)");
			}
			let error: NSError? = userInfo["error"] as? NSError;
			if error != nil {
				println("playbackDidFinish: error =  \(error!)");
			}
		}

		//Remove the moviePlayerController's view from the window.
		//(The window is the superview of the moviePlayerController's view.)
		let superview: UIView = moviePlayerController.view!.superview!;
		moviePlayerController.view.removeFromSuperview();

		//Put the big white View back into the window.
		superview.addSubview(save!);
		moviePlayerController.prepareToPlay();
		
		player!.play()
	}
	
	func playbackDidFinish2(notification: NSNotification) {
		//Print the two relevant items in the userInfo dictinary.
		if notification.userInfo != nil {
			let userInfo:[NSObject: AnyObject] = notification.userInfo!;
			let i: Int? = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as? Int;
			if i != nil && i! != MPMovieFinishReason.PlaybackEnded.rawValue {
				println("playbackDidFinish: reason = \(i!)");
			}
			let error: NSError? = userInfo["error"] as? NSError;
			if error != nil {
				println("playbackDidFinish: error =  \(error!)");
			}
		}

		//Remove the moviePlayerController's view from the window.
		//(The window is the superview of the moviePlayerController's view.)
		let superview2: UIView = moviePlayerController2.view!.superview!;
		moviePlayerController2.view.removeFromSuperview();

		//Put the big white View back into the window.
		superview2.addSubview(save!);
		moviePlayerController2.prepareToPlay();
		
		player!.play()
	}
	
	func playbackDidFinish3(notification: NSNotification) {
		//Print the two relevant items in the userInfo dictinary.
		if notification.userInfo != nil {
			let userInfo:[NSObject: AnyObject] = notification.userInfo!;
			let i: Int? = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as? Int;
			if i != nil && i! != MPMovieFinishReason.PlaybackEnded.rawValue {
				println("playbackDidFinish: reason = \(i!)");
			}
			let error: NSError? = userInfo["error"] as? NSError;
			if error != nil {
				println("playbackDidFinish: error =  \(error!)");
			}
		}

		//Remove the moviePlayerController's view from the window.
		//(The window is the superview of the moviePlayerController's view.)
		let superview3: UIView = moviePlayerController3.view!.superview!;
		moviePlayerController3.view.removeFromSuperview();

		//Put the big white View back into the window.
		superview3.addSubview(save!);
		moviePlayerController3.prepareToPlay();
		
		player!.play()
	}
	

	override func supportedInterfaceOrientations() -> Int {
		return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue);
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}
