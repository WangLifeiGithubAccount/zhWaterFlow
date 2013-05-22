//
//  WaterFlowViewController.m
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import "WaterFlowViewController.h"
#import "WaterFallView.h"
#import "WaterFallCell.h"
#import "UIImageView+WebCache.h"

#import <time.h>
#import <stdlib.h>

@interface WaterFlowViewController () <WaterFallViewDataSource, UIScrollViewDelegate>
{
    @private
    WaterFallView           *_waterFallView;
    NSMutableArray          *_listOfData;
    
    BOOL                    _isLoading;
}

@end

@implementation WaterFlowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        _listOfData = [[NSMutableArray alloc] initWithCapacity:10];
        
        for (int i = 0; i < 100; i++) {
            
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"7" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"8" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"9" ofType:@"jpg"]]];
//            [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]]];
            
            [_listOfData addObject:[UIImage imageNamed:@"1.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"2.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"3.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"4.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"5.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"6.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"7.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"8.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"9.jpg"]];
            [_listOfData addObject:[UIImage imageNamed:@"10.jpg"]];
        }
        
//        for (int j = 0; j < 20; j++) {
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=d57d750f00e9390156028a3e4fd455e7/ca1349540923dd54ffea6a47d009b3de9c824800.jpg"];
//            [_listOfData addObject:@"http://c.hiphotos.baidu.com/album/w%3D2048/sign=40f6d9cc562c11dfded1b823571f62d0/eaf81a4c510fd9f9f5054b46242dd42a2834a48a.jpg"];
//            [_listOfData addObject:@"http://f.hiphotos.baidu.com/album/w%3D2048/sign=d2ecf6da1b4c510faec4e51a5461242d/d1a20cf431adcbef23a15614adaf2edda3cc9f0e.jpg"];
//            [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=a38eaa710eb30f24359aeb03fcadd143/b151f8198618367a02b37ecd2f738bd4b31ce5ec.jpg"];
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=fe6e120643a7d933bfa8e3739973d013/8718367adab44aeddfae96f6b21c8701a08bfbc4.jpg"];
//            [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=89e0a6ead0c8a786be2a4d0e5331c83d/d1160924ab18972b78f806dae7cd7b899f510adb.jpg"];
//            [_listOfData addObject:@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=79e30a00bf096b6381195950380b8644/0dd7912397dda144de91a19db3b7d0a20cf48601.jpg"];
//            [_listOfData addObject:@"http://f.hiphotos.baidu.com/album/w%3D2048/sign=df24a7570824ab18e016e63701c2e7cd/8b82b9014a90f603fecfde363812b31bb051ed40.jpg"];
//            [_listOfData addObject:@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=52effe0ac75c1038247ec9c286299213/9a504fc2d56285355e622c3191ef76c6a7ef6324.jpg"];
//            [_listOfData addObject:@"http://g.hiphotos.baidu.com/album/w%3D2048/sign=3fa85c65203fb80e0cd166d702e92e2e/0823dd54564e9258ef48d6ba9d82d158ccbf4e61.jpg"];
//            
//            [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=299824e7d62a60595210e61a1c0c359b/caef76094b36acaf564a5ed27dd98d1001e99c72.jpg"];
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=34f6a59cb3b7d0a27bc9039dffd77709/8d5494eef01f3a29b4371ce09825bc315c607c25.jpg"];
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=c8f08fee83025aafd33279cbcfd5aa64/8601a18b87d6277f87ccfb1629381f30e824fcc6.jpg"];
//            [_listOfData addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=55e4300f738b4710ce2ffaccf7f6c2fd/c995d143ad4bd1139cb57f1c5bafa40f4bfb05a0.jpg"];
//            [_listOfData addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=060ac17354fbb2fb342b5f127b7221a4/37d3d539b6003af36563154e342ac65c1138b6c7.jpg"];
//            [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=d843700e00e9390156028a3e4fd455e7/ca1349540923dd54f2d46f46d009b3de9c82487d.jpg"];
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=34904ee542166d2238771294721b08f7/b7003af33a87e95054413a4211385343fbf2b44e.jpg"];
//            [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=d462df0194cad1c8d0bbfb274b066709/5366d0160924ab1873072e1934fae6cd7b890b8f.jpg"];
//            [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=1ed0f23a43a7d933bfa8e3739973d013/8718367adab44aed3f1076cab21c8701a18bfb46.jpg"];
//            [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=f82f653c730e0cf3a0f749fb3e7ef31f/faf2b2119313b07ea2fd98260dd7912397dd8c58.jpg"];
//        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (_waterFallView == nil) {
        _waterFallView = [[WaterFallView alloc] initWithFrame:[[self view] bounds]];
    }

    [_waterFallView setWaterFallDataSource:self];
    [_waterFallView setDelegate:self];
    [[self view] addSubview:_waterFallView];
    [_waterFallView release];
    
    srand(time(NULL));
    rand();
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_waterFallView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}


- (void)loadMoreCells:(void (^)())onComplete {
    if (!_isLoading) {
        _isLoading = true;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void) {
            
            for (int i = 0; i < 100; i++) {
                
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"4" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"6" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"7" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"8" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"9" ofType:@"jpg"]]];
//                [_listOfData addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"10" ofType:@"jpg"]]];
                
                [_listOfData addObject:[UIImage imageNamed:@"1.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"2.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"3.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"4.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"5.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"6.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"7.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"8.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"9.jpg"]];
                [_listOfData addObject:[UIImage imageNamed:@"10.jpg"]];
                
            }
            
//            for (int j = 0; j < 20; j++) {
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=d57d750f00e9390156028a3e4fd455e7/ca1349540923dd54ffea6a47d009b3de9c824800.jpg"];
//                [_listOfData addObject:@"http://c.hiphotos.baidu.com/album/w%3D2048/sign=40f6d9cc562c11dfded1b823571f62d0/eaf81a4c510fd9f9f5054b46242dd42a2834a48a.jpg"];
//                [_listOfData addObject:@"http://f.hiphotos.baidu.com/album/w%3D2048/sign=d2ecf6da1b4c510faec4e51a5461242d/d1a20cf431adcbef23a15614adaf2edda3cc9f0e.jpg"];
//                [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=a38eaa710eb30f24359aeb03fcadd143/b151f8198618367a02b37ecd2f738bd4b31ce5ec.jpg"];
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=fe6e120643a7d933bfa8e3739973d013/8718367adab44aeddfae96f6b21c8701a08bfbc4.jpg"];
//                [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=89e0a6ead0c8a786be2a4d0e5331c83d/d1160924ab18972b78f806dae7cd7b899f510adb.jpg"];
//                [_listOfData addObject:@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=79e30a00bf096b6381195950380b8644/0dd7912397dda144de91a19db3b7d0a20cf48601.jpg"];
//                [_listOfData addObject:@"http://f.hiphotos.baidu.com/album/w%3D2048/sign=df24a7570824ab18e016e63701c2e7cd/8b82b9014a90f603fecfde363812b31bb051ed40.jpg"];
//                [_listOfData addObject:@"http://d.hiphotos.baidu.com/album/w%3D2048/sign=52effe0ac75c1038247ec9c286299213/9a504fc2d56285355e622c3191ef76c6a7ef6324.jpg"];
//                [_listOfData addObject:@"http://g.hiphotos.baidu.com/album/w%3D2048/sign=3fa85c65203fb80e0cd166d702e92e2e/0823dd54564e9258ef48d6ba9d82d158ccbf4e61.jpg"];
//                
//                [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=299824e7d62a60595210e61a1c0c359b/caef76094b36acaf564a5ed27dd98d1001e99c72.jpg"];
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=34f6a59cb3b7d0a27bc9039dffd77709/8d5494eef01f3a29b4371ce09825bc315c607c25.jpg"];
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=c8f08fee83025aafd33279cbcfd5aa64/8601a18b87d6277f87ccfb1629381f30e824fcc6.jpg"];
//                [_listOfData addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=55e4300f738b4710ce2ffaccf7f6c2fd/c995d143ad4bd1139cb57f1c5bafa40f4bfb05a0.jpg"];
//                [_listOfData addObject:@"http://h.hiphotos.baidu.com/album/w%3D2048/sign=060ac17354fbb2fb342b5f127b7221a4/37d3d539b6003af36563154e342ac65c1138b6c7.jpg"];
//                [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=d843700e00e9390156028a3e4fd455e7/ca1349540923dd54f2d46f46d009b3de9c82487d.jpg"];
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=34904ee542166d2238771294721b08f7/b7003af33a87e95054413a4211385343fbf2b44e.jpg"];
//                [_listOfData addObject:@"http://e.hiphotos.baidu.com/album/w%3D2048/sign=d462df0194cad1c8d0bbfb274b066709/5366d0160924ab1873072e1934fae6cd7b890b8f.jpg"];
//                [_listOfData addObject:@"http://b.hiphotos.baidu.com/album/w%3D2048/sign=1ed0f23a43a7d933bfa8e3739973d013/8718367adab44aed3f1076cab21c8701a18bfb46.jpg"];
//                [_listOfData addObject:@"http://a.hiphotos.baidu.com/album/w%3D2048/sign=f82f653c730e0cf3a0f749fb3e7ef31f/faf2b2119313b07ea2fd98260dd7912397dd8c58.jpg"];
//            }
            
            _isLoading = false;
            
            if (onComplete != nil) {
                onComplete();
            }
        });
    }
}

#pragma mark - WaterFallViewDataSource

- (NSUInteger)numberOfColumnsForWaterFallView:(WaterFallView *)waterFallView
{
    return 6;
}

- (NSUInteger)numberOfCellsForWaterFallView:(WaterFallView *)waterFall
{
    return [_listOfData count];
}

- (CGFloat)waterFallView:(WaterFallView *)waterFallView heightOfCellAtIndex:(NSUInteger)index
{
    return 0.5f + 2.0f * ((CGFloat) rand() / INT_MAX);
}

- (WaterFallCell *)waterFallView:(WaterFallView *)waterFallView cellForRowAtIndex:(NSUInteger)index
{
    static NSString *identifier = @"identifier";
    WaterFallCell *cell = [waterFallView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[WaterFallCell alloc] initWithReuseIdentifier:identifier] autorelease];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
    
    cell.imageView.alpha = 0.0;
    [UIView animateWithDuration:0.15
                     animations:^{
                         cell.imageView.alpha = 1.0;
                     }];
    
    [cell.imageView setImage:[_listOfData objectAtIndex:index]];
//    [cell.imageView setImageWithURL:[NSURL URLWithString:[_listOfData objectAtIndex:index]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([_waterFallView contentOffset].y + [_waterFallView bounds].size.height >
        [_waterFallView contentSize].height) {
        [self loadMoreCells:^{
            [_waterFallView appendData];
        }];
    }
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_listOfData release];
    _listOfData = nil;
    [super dealloc];
}

@end
