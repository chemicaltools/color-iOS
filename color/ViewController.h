//
//  ViewController.h
//  color
//
//  Created by 曾晋哲 on 2017/1/16.
//  Copyright © 2017年 曾晋哲. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UILabel *label;
    UIButton *button_open;
    UIButton *button_camera;
    UIImageView *imageview;
    UIImageView *imageview_color;
}
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIButton *button_open;
@property (nonatomic, retain) IBOutlet UIButton *button_camera;
@property (nonatomic, retain) IBOutlet UIImageView *imageview;
@property (nonatomic, retain) IBOutlet UIImageView *imageview_color;
-(IBAction)open:(id)sender;
-(IBAction)camera:(id)sender;

@end

