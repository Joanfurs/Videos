//
//  View.swift
//  Videos
//
//  Created by Zhanna Fursova on 12/5/14.
//  Copyright (c) 2014 John Doe. All rights reserved.
//


import UIKit

class View: UIView {
	
	//Called from the loadView method of the ViewController.

	init(viewController: ViewController) {
		// Initialization code
		super.init(frame: CGRectZero);
		backgroundColor = UIColor.blackColor();
		
			
		//Center the switch in this View,
		let mySwitch: UISwitch = UISwitch(); //but don't give it a size.
		mySwitch.frame = CGRectMake(75, 20, 30, 30);
		mySwitch.tintColor = UIColor.greenColor();
		mySwitch.onTintColor = UIColor.greenColor();

		mySwitch.addTarget(viewController,
			action: "valueChanged:",
			forControlEvents: UIControlEvents.ValueChanged
		);

		addSubview(mySwitch);

		//Put the button in the center of this View and keep it there.
		let button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
		button.frame = CGRectMake(50, 90, 70, 40);

		button.backgroundColor = UIColor.clearColor();
		button.layer.borderWidth = 0.5;	//0.5 pairs of pixels = 1 pixel
		button.layer.borderColor = UIColor.clearColor().CGColor;
		button.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal);
		button.setTitle("Creepy", forState: UIControlState.Normal);

		button.addTarget(viewController,
			action: "touchUpInside:",
			forControlEvents: UIControlEvents.TouchUpInside);

		addSubview(button)
		
		
		
		let button2: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
		button2.frame = CGRectMake(35, 190, 70, 40);
		
		button2.backgroundColor = UIColor.clearColor();
		button2.layer.borderWidth = 0.5;	//0.5 pairs of pixels = 1 pixel
		button2.layer.borderColor = UIColor.clearColor().CGColor;
		button2.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal);
		button2.setTitle("Scary", forState: UIControlState.Normal);

		button2.addTarget(viewController,
			action: "touchUpInside2:",
			forControlEvents: UIControlEvents.TouchUpInside);

		addSubview(button2)
		
		let button3: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
		button3.frame = CGRectMake(50, 290, 70, 40);
		
		button3.backgroundColor = UIColor.clearColor();
		button3.layer.borderWidth = 0.5;	//0.5 pairs of pixels = 1 pixel
		button3.layer.borderColor = UIColor.clearColor().CGColor;
		button3.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal);
		button3.setTitle("Terrifying", forState: UIControlState.Normal);

		button3.addTarget(viewController,
			action: "touchUpInside3:",
			forControlEvents: UIControlEvents.TouchUpInside);

		addSubview(button3)
		
	}

	//Never called.
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
	
	
	override func drawRect(rect: CGRect) {
	
		
		let w: CGFloat = bounds.size.width;
		let h: CGFloat = bounds.size.height;

		let image: UIImage? = UIImage(named: "alien.jpg");
		if image == nil {
		println("could not find alien.jpg");
		return;
		}


		let point2: CGPoint = CGPointMake(
		(w - image!.size.width) / 2,
		(h - image!.size.height) / 2);

		image!.drawAtPoint(point2);
		
		
		/*
		let frame: CGRect = CGRectMake(130, 8, 300, 50);
		
		let label: UILabel = UILabel(frame: frame);
		label.backgroundColor = UIColor.clearColor();
		label.font = UIFont(name: "HelveticaNeue-Bold", size: 30);
		label.textColor = UIColor.greenColor();
		label.textAlignment = NSTextAlignment.Center;
		label.text = "alien: isolation";
		addSubview(label);
		*/
		
		}
	
}