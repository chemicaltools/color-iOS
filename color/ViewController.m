//
//  ViewController.m
//  color
//
//  Created by 曾晋哲 on 2017/1/16.
//  Copyright © 2017年 曾晋哲. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize label;
@synthesize button_open;
@synthesize button_camera;
@synthesize imageview;
@synthesize imageview_color;

-(IBAction)open:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
}

-(IBAction)camera:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        [self presentModalViewController:picker animated:YES];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    if (image != nil) {
        CGImageRef oldImageRef=image.CGImage;
        UIImage* newImage=[UIImage imageWithCGImage:oldImageRef];
        [imageview setImage:newImage];
    }
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [allTouches anyObject];
    CGPoint point = [touch locationInView:[touch view]];
    UIImage *image=[imageview image];
    CGImageRef cgImage = image.CGImage;
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    NSUInteger width = CGImageGetWidth(image.CGImage);
    NSUInteger height = CGImageGetHeight(image.CGImage);;
    NSInteger pointX = trunc(point.x)*width/size.width;
    NSInteger pointY = trunc(point.y)*height/size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    long rs=0,gs=0,bs=0,as=0,n=0;
    unsigned char pixelData[4];
    CGContextRef context = CGBitmapContextCreate(pixelData,1,1,bitsPerComponent,bytesPerRow,colorSpace,kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    for(long y=pointY-50;y<=pointY+50;y=y+1){
        for(long x=pointX-50;x<=pointX+50;x=x+1){
            CGContextSetBlendMode(context, kCGBlendModeCopy);
            CGContextTranslateCTM(context, -(x), (y)-(CGFloat)height);
            CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
            if(x>0&&x<=width&&y>0&&y<=height){
                rs=rs+pixelData[0];
                gs=gs+pixelData[1];
                bs=bs+pixelData[2];
                as=as+pixelData[3];
                n=n+1;
                CGContextTranslateCTM(context, (x), -(y)-(CGFloat)height);
            }
        }
    }
    long r=rs/n,g=gs/n,b=bs/n,a=as/n;
    CGFloat red   = (CGFloat)r / 255.0f;
    CGFloat green = (CGFloat)g / 255.0f;
    CGFloat blue  = (CGFloat)b / 255.0f;
    CGFloat alpha = (CGFloat)a / 255.0f;
    CGFloat c= ((float)r/(float)g/0.5-0.53012)/0.798507*50;
    label.text=[NSString stringWithFormat:@"R:%@, G:%@, B:%@, c=%@",[NSString stringWithFormat:@"%ld",r],[NSString stringWithFormat:@"%ld",g],[NSString stringWithFormat:@"%ld",b],[NSString stringWithFormat:@"%f",c]];
    [imageview_color setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:alpha]];
}

@end
