//
//  RadioViewController.m
//  AlarmManager
//
//  Created by vince chao on 15/5/20.
//  Copyright (c) 2015年 vince chao. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "RadioViewController.h"
#import "BTRippleButton/BTRippleButtton.h"
#import "AWCollectionViewDialLayout.h"
#define WIDTH self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface RadioViewController ()


@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *items;


@end
static NSString *cellId = @"cellId";



@implementation RadioViewController{
    NSMutableDictionary *thumbnailCache;
    BOOL showingSettings;
    UIView *settingsView;
    
    UILabel *radiusLabel;
    UISlider *radiusSlider;
    UILabel *angularSpacingLabel;
    UISlider *angularSpacingSlider;
    UILabel *xOffsetLabel;
    UISlider *xOffsetSlider;
    UISegmentedControl *exampleSwitch;
    AWCollectionViewDialLayout *dialLayout;
    
    int type;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    background.frame = self.view.frame;
    [self.view addSubview:background];
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.9];

    type = 0;
    showingSettings = NO;
    
    CGFloat cell_width = 370 * (WIDTH / 375);
    CGFloat cell_height = 300 * (HEIGHT / 667);
    dialLayout = [[AWCollectionViewDialLayout alloc] initWithRadius:350 * (WIDTH / 375)andAngularSpacing:45 * (WIDTH / 375)andCellSize:CGSizeMake(cell_width, cell_height) andAlignment:WHEELALIGNMENTCENTER andItemHeight:cell_height andXOffset:180 * (WIDTH / 375)];
    
    self.collectionView= [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:dialLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"dialCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellId];
    
    
    
    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"RadioList" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
    self.items = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    [self createButton];
    
    
}

- (void)createButton
{
    CGAdapter my = [AdapterModel getCGAdapter];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    bu.frame = CGRectMake(280 * my.sWidth, 540 * my.sHeight, 60 * my.sWidth, 60 * my.sWidth);
    [bu setImage:[UIImage imageNamed:@"pin"] forState:UIControlStateNormal];
    bu.tintColor = [UIColor redColor];
    bu.layer.cornerRadius = 60 * my.sWidth / 2;
    [self.view addSubview:bu];
    [bu addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rLabel = [[UILabel alloc] initWithFrame:CGRectMake(240 * my.sWidth, 40 * my.sHeight, 100 * my.sWidth, 40 * my.sHeight)];
    [self.view addSubview:self.rLabel];
    self.rLabel.text = @"正在播放...";
    self.rLabel.font = [UIFont systemFontOfSize:18 * my.sHeight];
    self.rLabel.textColor = [UIColor whiteColor];
    self.rLabel.hidden = YES;
}

- (void)buttonTapped:(id)sender
{
    Radio *radioPlayer = [Radio sharedInstance];
    [radioPlayer stop];
    self.rLabel.hidden = YES;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    
    cell = [cv dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    NSDictionary *item = [self.items objectAtIndex:indexPath.item];
    
    NSString *playerName = [item valueForKey:@"name"];
    UILabel *nameLabel = (UILabel*)[cell viewWithTag:101];
    [nameLabel setText:playerName];
    
    
    NSString *hexColor = [item valueForKey:@"team-color"];
    
    UIView *borderView = [cell viewWithTag:102];
    borderView.layer.borderColor = [self colorFromHex:hexColor].CGColor;
    
    NSString *imgURL = [item valueForKey:@"picture"];
    UIImageView *imgView = (UIImageView*)[cell viewWithTag:100];
    [imgView setImage:nil];
    __block UIImage *imageProduct = [thumbnailCache objectForKey:imgURL];
    if(imageProduct){
        imgView.image = imageProduct;
    }
    else{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [UIImage imageNamed:imgURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                imgView.image = image;
                [thumbnailCache setValue:image forKey:imgURL];
            });
        });
    }
    
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"didEndDisplayingCell:%i", (int)indexPath.item);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0 , 0, 0, 0);
}

- (unsigned int)intFromHexString:(NSString *)hexStr
{
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    return hexInt;
}

-(UIColor*)colorFromHex:(NSString*)hexString{
    unsigned int hexint = [self intFromHexString:hexString];
    
    // Create color object, specifying alpha as well
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1];
    
    return color;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Radio *radioPlayer = [Radio sharedInstance];
    
    switch (indexPath.row) {
        case 0:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/386.m3u8"];
            [radioPlayer play];
            break;
        case 1:
            self.rLabel.hidden = NO;

            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/2256689.m3u8"];
            [radioPlayer play];
            
            break;
        case 2:
            self.rLabel.hidden = NO;

            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/395.m3u8"];
            [radioPlayer play];
            break;
        case 3:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/387.m3u8"];
            [radioPlayer play];
            break;
        case 4:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/388.m3u8"];
            [radioPlayer play];
            break;
        case 5:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/389.m3u8"];
            [radioPlayer play];
            break;
        case 6:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/1014.m3u8"];
            [radioPlayer play];
            break;
        case 7:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/1017.m3u8"];
            [radioPlayer play];
            break;
        case 8:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/998.m3u8"];
            [radioPlayer play];
            break;
        case 9:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/24035.m3u8"];
            [radioPlayer play];
            break;
        case 10:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/1009.m3u8"];
            [radioPlayer play];
            break;
        case 11:
            self.rLabel.hidden = NO;
            [radioPlayer setRadioUrlString:@"http://42.96.249.166/live/1749691.m3u8"];
            [radioPlayer play];
                default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
