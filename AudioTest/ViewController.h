//
//  ViewController.h
//  AudioTest
//
//  Created by John Stewart on 8/21/13.
//  Copyright (c) 2013 John Stewart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *numberSlider;
- (IBAction)playPressed:(id)sender;
- (IBAction)minusPressed:(id)sender;
- (IBAction)plusPressed:(id)sender;

@end
