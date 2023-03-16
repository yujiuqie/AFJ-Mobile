//
//  AFJFilterViewController.m
//  AFJ-iOS
//
//  Created by Alfred on 2022/9/20.
//

#import "AFJFilterViewController.h"
#import "IFImageFilter.h"
#import "GPUImage.h"

@interface AFJFilterViewController ()
{
    NSArray<Class>* instagramFilters;
    NSInteger _filterIndex;
    GPUImagePicture *stillImageSource;
}

@property(nonatomic, strong) GPUImageView *imageView;
@property(nonatomic, strong) UILabel *filterLabel;
@property(nonatomic, strong) UIButton *nextBtn;

@end

@implementation AFJFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filterLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5, 400, 40)];
    _filterLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_filterLabel];
  
    _imageView = [[GPUImageView alloc] initWithFrame:CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5 + 40 + 5, 400, 400)];
    [self.view addSubview:_imageView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((SCREENW - 400)/2.0, StatusBarAndNavigationBarHeight + 5 + 40 + 5 + 400 + 5, 400, 40);
    [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
    _nextBtn.backgroundColor = [UIColor redColor];
    [_nextBtn addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    UIImage *inputImage = [UIImage imageNamed:@"fjjwtx (252).jpg"];
    
    _filterIndex = 0;
    instagramFilters = [IFImageFilter allFilterClasses];
    
    stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    [self changeFilter];
}

- (void)changeFilter {
    
    NSInteger filterIndex = (_filterIndex++ % instagramFilters.count);
    
    [stillImageSource removeAllTargets];
    
    IFImageFilter *imageFilter = [[[instagramFilters objectAtIndex:filterIndex] alloc] init];
    [imageFilter addTarget:self.imageView];
    
    [stillImageSource addTarget:imageFilter];
    
    [imageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    
    [imageFilter imageFromCurrentFramebuffer];
    [self.filterLabel setText:[NSString stringWithFormat:@"%@ (%ld/%ld)", imageFilter.name, filterIndex+1, instagramFilters.count]];
}

@end
